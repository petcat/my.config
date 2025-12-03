#!/bin/bash
set -euo pipefail

# 统一路径变量
BIN_PATH=${BIN_PATH:-/opt/filebrowser}

# 安装 filebrowser
curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

# 放置可执行文件
mkdir -p "$BIN_PATH"
mv "$(which filebrowser)" "$BIN_PATH/filebrowser"

# systemd 服务
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
ExecStart=$BIN_PATH/filebrowser -d $BIN_PATH/filebrowser.db
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable filebrowser.service

# 配置变量
ADDRESS=${ADDRESS:-0.0.0.0}    # 127.0.0.1 / 0.0.0.0 / [::]
LISTEN_PORT=${LISTEN_PORT:-8090}
LANGUAGE=${LANGUAGE:-zh-cn}
USERNAME=${USERNAME:-aming}
PASSWORD=$(openssl rand -base64 16 | tr -dc 'a-zA-Z0-9' | head -c16)
LOG_PATH=${LOG_PATH:-/var/log/filebrowser.log}
SCOPE_DIR=${SCOPE_DIR:-/srv}

# 地址合法性
case "$ADDRESS" in
  "127.0.0.1"|"0.0.0.0"|"[::]") ;;
  *) echo "ADDRESS 只能为 127.0.0.1 / 0.0.0.0 / [::]"; exit 1 ;;
esac

# 预创建 scope 目录与日志文件
mkdir -p "$SCOPE_DIR"
mkdir -p "$(dirname "$LOG_PATH")"
touch "$LOG_PATH"

# 初始化配置数据库
"$BIN_PATH/filebrowser" -d "$BIN_PATH/filebrowser.db" config init

# 正确设置项：地址、端口、语言、日志、默认目录
"$BIN_PATH/filebrowser" -d "$BIN_PATH/filebrowser.db" config set --address "$ADDRESS"
"$BIN_PATH/filebrowser" -d "$BIN_PATH/filebrowser.db" config set --port "$LISTEN_PORT"
"$BIN_PATH/filebrowser" -d "$BIN_PATH/filebrowser.db" config set --locale "$LANGUAGE"
"$BIN_PATH/filebrowser" -d "$BIN_PATH/filebrowser.db" config set --log "$LOG_PATH"
"$BIN_PATH/filebrowser" -d "$BIN_PATH/filebrowser.db" config set --scope "$SCOPE_DIR"

# 可选：自动创建用户目录（按需启用）
# "$BIN_PATH/filebrowser" -d "$BIN_PATH/filebrowser.db" config set --createUserDir

# 添加管理员用户
"$BIN_PATH/filebrowser" -d "$BIN_PATH/filebrowser.db" users add "$USERNAME" "$PASSWORD" --perm.admin

# 启动服务
systemctl start filebrowser.service

# 一次性输出所有配置信息
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
