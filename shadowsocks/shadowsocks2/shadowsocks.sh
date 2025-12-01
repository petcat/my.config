#!/bin/bash
set -e

INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="/etc/shadowsocks-rust"
SERVICE_FILE="/etc/systemd/system/shadowsocks.service"
REMOTE_CONF_URL="https://raw.githubusercontent.com/petcat/my.config/refs/heads/master/shadowsocks/shadowsocks2/config.json"

function install_tools() {
    apt update && apt install -y curl unzip jq
}

function get_local_version() {
    if [ -x "$INSTALL_DIR/ssserver" ]; then
        $INSTALL_DIR/ssserver -V 2>/dev/null | awk '{print $2}'
    else
        echo "none"
    fi
}

function get_latest_version() {
    curl -s https://api.github.com/repos/shadowsocks/shadowsocks-rust/releases/latest \
        | jq -r '.tag_name'
}

function download_latest() {
    echo "🔍 正在获取最新版本..."
    LATEST_URL=$(curl -s https://api.github.com/repos/shadowsocks/shadowsocks-rust/releases/latest \
        | jq -r '.assets[] | select(.name | test("x86_64-unknown-linux-gnu.tar.xz$")) | .browser_download_url')
    echo "⬇️ 下载: $LATEST_URL"
    curl -L "$LATEST_URL" -o /tmp/ssr.tar.xz
    tar -xf /tmp/ssr.tar.xz -C /tmp
}

function install_ss() {
    install_tools
    mkdir -p "$CONFIG_DIR"
    download_latest
    install -m 755 /tmp/ssserver "$INSTALL_DIR/ssserver"

    # 默认配置文件
    cat > "$CONFIG_DIR/config.json" <<EOF
{
    "server": "::",
    "server_port": 20443,
    "password": "A9cF9aFFbB11c72c49fC10bDF0f75eeD",
    "method": "aes-128-gcm",
    "mode": "tcp_only"
}
EOF

    # systemd 服务
    cat > "$SERVICE_FILE" <<EOF
[Unit]
Description=Shadowsocks-Rust Server
After=network.target

[Service]
ExecStart=$INSTALL_DIR/ssserver -c $CONFIG_DIR/config.json
Restart=on-failure
User=nobody
Group=nogroup
LimitNOFILE=32768

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reexec
    systemctl daemon-reload
    systemctl enable shadowsocks
    systemctl start shadowsocks
    systemctl status shadowsocks
    echo "✅ Shadowsocks-Rust 安装与启动完成！"
}

function upgrade_ss() {
    local_version=$(get_local_version)
    latest_version=$(get_latest_version)

    echo "本地版本: $local_version"
    echo "最新版本: $latest_version"

    if [ "$local_version" = "$latest_version" ]; then
        echo "⚡ 已是最新版本，无需升级。"
        return
    fi

    echo "🔄 正在升级 Shadowsocks-Rust..."
    download_latest
    systemctl stop shadowsocks
    install -m 755 /tmp/ssserver "$INSTALL_DIR/ssserver"
    systemctl start shadowsocks
    echo "✅ Shadowsocks-Rust 已升级到版本 $latest_version 并重新启动！"
}

function update_conf() {
    echo "📥 正在下载远程配置文件..."
    curl -L "$REMOTE_CONF_URL" -o "$CONFIG_DIR/config.json"
    echo "✅ 配置文件已更新: $CONFIG_DIR/config.json"
    systemctl restart shadowsocks
    echo "🔄 Shadowsocks 服务已重启以应用新配置。"
}

case "$1" in
    -up)
        upgrade_ss
        ;;
    -conf)
        update_conf
        ;;
    *)
        install_ss
        ;;
esac
