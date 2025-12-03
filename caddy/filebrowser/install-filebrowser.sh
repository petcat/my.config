#!/bin/bash

# 运行官方 filebrowser 安装脚本
curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

# 创建安装目录并移动 filebrowser 可执行文件
mkdir -p /opt/filebrowser
mv $(which filebrowser) /opt/filebrowser/filebrowser

# systemd 服务文件路径及备份文件路径
SERVICE_FILE="/etc/systemd/system/filebrowser.service"
BACKUP_FILE="/etc/systemd/system/filebrowser.bak"

# 如果服务文件存在则备份，否则创建新的服务文件
if [ -f "$SERVICE_FILE" ]; then
  echo "备份已有的 filebrowser.service 到 filebrowser.bak"
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
ExecStart=/opt/filebrowser/filebrowser -d /opt/filebrowser/filebrower.db
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
USERNAME=${USERNAME:-admin}
PASSWORD=$(openssl rand -base64 16 | tr -dc 'a-zA-Z0-9' | head -c16)
LOG_PATH=${LOG_PATH:-/var/log/filebrowser.log}
SCOPE_DIR=${SCOPE_DIR:-/srv}

# 初始化配置数据库
/opt/filebrowser/filebrowser -d /opt/filebrowser/filebrower.db config init

# 设置监听地址和端口
/opt/filebrowser/filebrowser -d /opt/filebrowser/filebrower.db config set --address 0.0.0.0:$LISTEN_PORT

# 设置语言
/opt/filebrowser/filebrowser -d /opt/filebrowser/filebrower.db config set --locale $LANGUAGE

# 设置日志路径
/opt/filebrowser/filebrowser -d /opt/filebrowser/filebrower.db config set --log $LOG_PATH

# 设置默认目录
/opt/filebrowser/filebrowser -d /opt/filebrowser/filebrower.db config set --scope $SCOPE_DIR

# 添加用户并赋予管理员权限
/opt/filebrowser/filebrowser -d /opt/filebrowser/filebrower.db users add $USERNAME $PASSWORD --perm.admin

# 启动 filebrowser 服务
systemctl start filebrowser.service

# 一次性输出所有配置信息
echo "=============================="
echo " Filebrowser 已安装并启动成功 "
echo "------------------------------"
echo "监听地址: 0.0.0.0:$LISTEN_PORT"
echo "语言: $LANGUAGE"
echo "用户名: $USERNAME"
echo "密码: $PASSWORD"
echo "日志路径: $LOG_PATH"
echo "默认目录: $SCOPE_DIR"
echo "数据库文件: /opt/filebrowser/filebrower.db"
echo "=============================="
