#!/bin/bash  


# 运行官方 filebrowser 安装脚本
curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

# 创建安装目录并移动 filebrowser 可执行文件
mkdir -p /opt/filebrowser
mv $(which filebrowser) /opt/filebrowser/filebrowser

#systemd 服务文件路径及备份文件路径
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
ExecStart=/opt/filebrowser/filebrowser -d /opt/filebrowser/filebrowers.db
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# 重新加载 systemd 并启用服务
systemctl daemon-reload
systemctl enable filebrowser.service

$#配置变量，方便修改
LISTEN_PORT=${LISTEN_PORT:-8080}
LANGUAGE=${LANGUAGE:-zh-cn}
USERNAME=${USERNAME:-aming}
PASSWORD=${PASSWORD:-1qaz2wsx3edc}

# 初始化配置数据库
/opt/filebrowser/filebrowser -d /etc/filebrowser.db config init

echo "设置监听地址和端口为: 0.0.0.0:$LISTEN_PORT"
/opt/filebrowser/filebrowser -d /opt/filebrowser/filebrowers.db config set --address 0.0.0.0:$LISTEN_PORT

echo "设置语言为: $LANGUAGE"
/opt/filebrowser/filebrowser -d /opt/filebrowser/filebrowers.db config set --locale $LANGUAGE

echo "添加用户: $USERNAME，密码: $PASSWORD，赋予管理员权限"
/opt/filebrowser/filebrowser -d /opt/filebrowser/filebrowers.db users add $USERNAME $PASSWORD --perm.admin

# 启动 filebrowser 服务
systemctl start filebrowser.service
