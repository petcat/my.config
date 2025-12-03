#!/bin/bash
set -euo pipefail

# 安装目录变量
BIN_PATH=${BIN_PATH:-/opt/filebrowser}

# 运行官方 filebrowser 安装脚本
curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

# 创建安装目录并移动 filebrowser 可执行文件
mkdir -p "$BIN_PATH"
mv "$(which filebrowser)" "$BIN_PATH/filebrowser"

# systemd 服务文件路径及备份文件路径
SERVICE_FILE="/etc/systemd/system/filebrowser.service"
BACKUP_FILE="/etc/systemd/system/filebrowser.bak"

# 如果服务文件存在则备份，否则创建新的服务文件
if [ -f "$SERVICE_FILE" ]; then
  mv "$SERVICE_FILE" "$BACKUP_FILE"
fi

# 创建新的 filebrowser.service 文件
cat <<EOF > "$SERVICE_FILE"
[Unit]
Description=File Browser
After=network.target

[Service]
User=root
Group=root
ExecStart=$BIN_PATH/filebrowser -d $BIN_PATH/filebrowser.db
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# 重新加载 systemd 并启用服务
systemctl daemon-reload
systemctl enable filebrowser.service

# 配置变量，方便修改
LISTEN_PORT=${LISTEN_PORT:-8090}
LANGUAGE=${LANGUAGE:-zh-cn}
USERNAME=${USERNAME:-aming}
PASSWORD=$(openssl rand -base64 16 | tr -dc 'a-zA-Z0-9' | head -c16)
LOG_PATH=${LOG_PATH:-/var/log/filebrowser.log}
SCOPE_DIR=${SCOPE_DIR:-/srv}
ADDRESS=${ADDRESS:-0.0.0.0}   # 可选：127.0.0.1 / 0.0.0.0 / [::]

# 合法性检查：监听地址必须为三选一
case "$ADDRESS" in
  "127.0.0.1"|"0.0.0.0"|"[::]") ;;
  *) echo "ADDRESS 只能为 127.0.0.1 / 0.0.0.0 / [::]"; exit 1 ;;
esac

# 初始化配置数据库
$BIN_PATH/filebrowser -d "$BIN_PATH/filebrowser.db" config init

# 单独设置监听地址与端口
$BIN_PATH/filebrowser -d "$BIN_PATH/filebrowser.db" config set --address "$ADDRESS"
$BIN_PATH/filebrowser -d "$BIN_PATH/filebrowser.db" config set --port "$LISTEN_PORT"

# 设置语言、日志路径、默认目录
$BIN_PATH/filebrowser -d "$BIN_PATH/filebrowser.db" config set --locale "$LANGUAGE"
$BIN_PATH/filebrowser -d "$BIN_PATH/filebrowser.db" config set --log "$LOG_PATH"
$BIN_PATH/filebrowser -d "$BIN_PATH/filebrowser.db" config set --scope "$SCOPE_DIR"

# 添加用户并赋予管理员权限
$BIN_PATH/filebrowser -d "$BIN_PATH/filebrowser.db" users add "$USERNAME" "$PASSWORD" --perm.admin

# 启动 filebrowser 服务
systemctl start filebrowser.service

# 一次性输出所有配置信息（合并地址+端口）
cat <<INFO
==============================
Filebrowser 已安装并启动成功
------------------------------
监听: $ADDRESS:$LISTEN_PORT
语言: $LANGUAGE
用户名: $USERNAME
密码: $PASSWORD
日志路径: $LOG_PATH
默认目录: $SCOPE_DIR
数据库文件: $BIN_PATH/filebrowser.db
安装目录: $BIN_PATH
==============================
INFO
