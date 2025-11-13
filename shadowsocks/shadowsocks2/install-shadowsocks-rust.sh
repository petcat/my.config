#!/bin/bash
set -e
# 1. 安裝必要工具
apt update && apt install -y curl unzip jq

# 2. 建立安裝目錄
INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="/etc/shadowsocks-rust"
SERVICE_FILE="/etc/systemd/system/shadowsocks.service"

mkdir -p "$CONFIG_DIR"

# 3. 下載 shadowsocks-rust 最新版本
echo "🔍 正在獲取最新版本..."
LATEST_URL=$(curl -s https://api.github.com/repos/shadowsocks/shadowsocks-rust/releases/latest | \
  jq -r '.assets[] | select(.name | test("x86_64-unknown-linux-gnu.tar.xz$")) | .browser_download_url')

echo "⬇️ 下載: $LATEST_URL"
curl -L "$LATEST_URL" -o /tmp/ssr.tar.xz

# 4. 解压并安装
tar -xf /tmp/ssr.tar.xz -C /tmp
install -m 755 /tmp/ssserver "$INSTALL_DIR/ssserver"

# 5. 建立配置
cat > "$CONFIG_DIR/config.json" <<EOF
{
  "server": "::",
  "server_port": 20443,
  "password": "A9cF9aFFbB11c72c49fC10bDF0f75eeD",
  "method": "aes-128-gcm",
  "mode": "tcp_only"
}
EOF

# 6. 建立 systemd 服務
cat > "$SERVICE_FILE" <<EOF
[Unit]
Description=Shadowsocks-Rust Server
After=network.target

[Service]
ExecStart=/usr/local/bin/ssserver -c /etc/shadowsocks-rust/config.json
Restart=on-failure
User=nobody
Group=nogroup
LimitNOFILE=32768

[Install]
WantedBy=multi-user.target
EOF

# 7. 啟用並啟動服務
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable shadowsocks
systemctl start shadowsocks
systemctl status shadowsocks
echo "✅ Shadowsocks-Rust 安裝與啟動完成！"
