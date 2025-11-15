#!/bin/bash
# 自动化安装哪吒服务端 Dashboard
# 自动获取最新版本号，服务文件名为 nezha.service

set -e

INSTALL_DIR="/opt/nezha"
SERVICE_FILE="/etc/systemd/system/nezha.service"

echo "开始安装哪吒服务端..."

# 1. 创建安装目录
mkdir -p $INSTALL_DIR

# 2. 获取最新版本号
VERSION=$(curl -s https://api.github.com/repos/nezhahq/nezha/releases/latest | grep tag_name | cut -d '"' -f4)

echo "最新版本号: $VERSION"

# 3. 下载并解压最新版本
wget -O nezha-dashboard.zip https://github.com/nezhahq/nezha/releases/download/${VERSION}/dashboard-linux-amd64.zip
unzip nezha-dashboard.zip -d $INSTALL_DIR
rm -f nezha-dashboard.zip

# 4. 创建 systemd 服务 (nezha.service)
cat >$SERVICE_FILE <<EOF
[Unit]
Description=Nezha Monitoring Dashboard
After=network.target

[Service]
WorkingDirectory=$INSTALL_DIR
ExecStart=$INSTALL_DIR/dashboard-linux-amd64
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

# 5. 启动并设置开机自启
systemctl daemon-reexec
systemctl enable nezha.service
systemctl start nezha.service

echo "哪吒服务端安装完成！"
echo "默认监听端口：8008"
echo "请访问 http://服务器IP:8008 初始化面板"
