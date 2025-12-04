#!/bin/bash
set -euo pipefail

######################################################
# 配置变量（端口语言日志等）
######################################################

ADDRESS=${ADDRESS:-0.0.0.0}    # 可选：127.0.0.1 / 0.0.0.0 / [::]
LISTEN_PORT=${LISTEN_PORT:-8090}
LANGUAGE=${LANGUAGE:-zh-cn}
LOG_PATH=${LOG_PATH:-/var/log/filebrowser.log}

# 主程序路径，官方脚本默认为 /usr/local/bin/ 修改为 /opt/filebrowser/
BIN_PATH=${BIN_PATH:-/opt/filebrowser}
DB_FILE="$BIN_PATH/filebrowser.db"

######################################################
# 官方脚本下载 filebrowser 并生成 systemd 服务
######################################################

if [[ "${1:-}" != "-pw" && "${1:-}" != "-add" && "${1:-}" != "-ls" && "${1:-}" != "-upgrade" ]]; then
  curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

  mkdir -p "$BIN_PATH"
  mv "$(which filebrowser)" "$BIN_PATH/filebrowser"

  SERVICE_FILE="/etc/systemd/system/filebrowser.service"
  BACKUP_FILE="/etc/systemd/system/filebrowser.bak"

  if [ -f "$SERVICE_FILE" ]; then
    mv "$SERVICE_FILE" "$BACKUP_FILE"
  fi

  cat <<EOF > "$SERVICE_FILE"
[Unit]
Description=File Browser
After=network.target

[Service]
User=root
Group=root
ExecStart=$BIN_PATH/filebrowser -d $DB_FILE
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

  systemctl daemon-reload
  systemctl enable filebrowser.service

  ######################################################
  # 初始化配置与添加用户
  ######################################################

  mkdir -p "$(dirname "$LOG_PATH")"
  touch "$LOG_PATH"

  "$BIN_PATH/filebrowser" -d "$DB_FILE" config init \
    --address "$ADDRESS" \
    --port "$LISTEN_PORT" \
    --locale "$LANGUAGE" \
    --log "$LOG_PATH"

  # 交互式输入用户名和密码
  read -p "请输入用户名 (默认: admin): " INPUT_USER
  read -p "请输入密码 (默认: 随机16位): " INPUT_PASS

  USERNAME=${INPUT_USER:-admin}
  PASSWORD=${INPUT_PASS:-$(openssl rand -base64 16 | tr -dc 'a-zA-Z0-9' | head -c16)}

  "$BIN_PATH/filebrowser" -d "$DB_FILE" users add "$USERNAME" "$PASSWORD" --perm.admin

  systemctl start filebrowser.service

  cat <<INFO
==============================
Filebrowser 已安装并启动成功
------------------------------
监听: $ADDRESS:$LISTEN_PORT
语言: $LANGUAGE
用户名: $USERNAME
密码: $PASSWORD
日志路径: $LOG_PATH
数据库文件: $DB_FILE
安装目录: $BIN_PATH
==============================
INFO
fi

######################################################
# 额外功能：修改密码 / 添加用户 / 列出用户 / 升级
######################################################

if [[ "${1:-}" == "-pw" ]]; then
  systemctl stop filebrowser.service
  read -p "请输入新密码 (默认: 随机16位): " INPUT_PASS
  NEW_PASS=${INPUT_PASS:-$(openssl rand -base64 16 | tr -dc 'a-zA-Z0-9' | head -c16)}
  "$BIN_PATH/filebrowser" -d "$DB_FILE" users update 1 -p "$NEW_PASS"
  systemctl start filebrowser.service
  echo "=============================="
  echo "用户 ID=1 密码已更新"
  echo "新密码: $NEW_PASS"
  echo "=============================="
  exit 0
fi

if [[ "${1:-}" == "-add" ]]; then
  if [[ -z "${2:-}" || -z "${3:-}" ]]; then
    echo "用法: $0 -add <用户名> <密码>"
    exit 1
  fi
  NEW_USER="$2"
  NEW_PASS="$3"
  "$BIN_PATH/filebrowser" -d "$DB_FILE" users add "$NEW_USER" "$NEW_PASS"
  echo "=============================="
  echo "已添加普通用户"
  echo "用户名: $NEW_USER"
  echo "密码: $NEW_PASS"
  echo "=============================="
  exit 0
fi

if [[ "${1:-}" == "-ls" ]]; then
  echo "=============================="
  echo "当前用户列表:"
  "$BIN_PATH/filebrowser" -d "$DB_FILE" users ls
  echo "=============================="
  exit 0
fi

if [[ "${1:-}" == "-upgrade" ]]; then
  echo "检查当前版本..."
  CURRENT_VER=$("$BIN_PATH/filebrowser" version | awk '{print $NF}')
  echo "当前版本: $CURRENT_VER"

  echo "获取最新版本..."
  LATEST_VER=$(curl -s https://api.github.com/repos/filebrowser/filebrowser/releases/latest | grep tag_name | cut -d '"' -f4)
  echo "最新版本: $LATEST_VER"

  if [[ "$CURRENT_VER" == "$LATEST_VER" ]]; then
    echo "=============================="
    echo "Filebrowser 已是最新版本 ($CURRENT_VER)"
    echo "无需升级"
    echo "=============================="
  else
    echo "发现新版本，开始升级..."
    curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash
    mv "$(which filebrowser)" "$BIN_PATH/filebrowser"
    echo "升级完成，新版本:"
    "$BIN_PATH/filebrowser" version
  fi
  exit 0
fi
