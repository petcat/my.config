#!/usr/bin/env bash
set -e
# 检测架构
ARCH="$(uname -m)"
case "$ARCH" in
  x86_64) ASSET="dpanel-amd64" ;;
  aarch64) ASSET="dpanel-arm64" ;;
  armv7l|armv6l) ASSET="dpanel-arm" ;;
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac
# 获取最新版本号
LATEST_TAG=$(curl -s https://api.github.com/repos/donknap/dpanel/releases/latest \
  | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

echo "Latest version: $LATEST_TAG"

# 下载二进制和官方配置
BIN_URL="https://github.com/donknap/dpanel/releases/download/${LATEST_TAG}/${ASSET}"
CFG_URL="https://github.com/donknap/dpanel/releases/download/${LATEST_TAG}/config.yaml"

# 创建安装目录
mkdir -p /opt/dpanel

echo "Downloading binary: $BIN_URL"
wget -O /opt/dpanel/dpanel "$BIN_URL"
chmod +x /opt/dpanel/dpanel

echo "Downloading config: $CFG_URL"
wget -O /opt/dpanel/config.yaml "$CFG_URL"

# 创建 systemd 服务
cat >/etc/systemd/system/dpanel.service <<EOF
[Unit]
Description=DPanel Server
After=network.target

[Service]
ExecStart=/opt/dpanel/dpanel server:start -f /opt/dpanel/config.yaml
Restart=always
User=root
WorkingDirectory=/opt/dpanel

[Install]
WantedBy=multi-user.target
EOF

# 启动服务
systemctl daemon-reload
systemctl enable dpanel
systemctl start dpanel

echo "✅ DPanel $LATEST_TAG 已安装并启动成功！"
