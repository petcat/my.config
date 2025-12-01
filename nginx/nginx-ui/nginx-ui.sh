#!/bin/bash
set -e

INSTALL_DIR="/opt/nginx-ui"
CONFIG_FILE="$INSTALL_DIR/app.ini"
BIN_FILE="$INSTALL_DIR/nginx-ui"

# 检查 root 权限
if [ "$(id -u)" -ne 0 ]; then
  echo "请使用 root 权限运行此脚本"
  exit 1
fi

# 检查系统类型
OS="$(uname -s)"
ARCH="$(uname -m)"

echo "检测到系统: $OS, 架构: $ARCH"

# 判断架构映射
case "$ARCH" in
  x86_64|amd64)
    ARCH_DL="amd64"
    ;;
  aarch64|arm64)
    ARCH_DL="arm64"
    ;;
  armv7l|armv6l)
    ARCH_DL="armv7"
    ;;
  *)
    echo "暂不支持的架构: $ARCH"
    exit 1
    ;;
esac

# 判断是否 Alpine
if [ -f /etc/alpine-release ]; then
  echo "检测到 Alpine Linux"
  PKG_MANAGER="apk"
else
  if command -v apt >/dev/null 2>&1; then
    PKG_MANAGER="apt"
  elif command -v yum >/dev/null 2>&1; then
    PKG_MANAGER="yum"
  elif command -v dnf >/dev/null 2>&1; then
    PKG_MANAGER="dnf"
  else
    PKG_MANAGER="unknown"
  fi
fi

echo "使用包管理器: $PKG_MANAGER"

# 安装依赖
case "$PKG_MANAGER" in
  apk)
    apk update
    apk add curl bash tar
    ;;
  apt)
    apt update
    apt install -y curl bash tar
    ;;
  yum)
    yum install -y curl bash tar
    ;;
  dnf)
    dnf install -y curl bash tar
    ;;
  *)
    echo "请手动安装 curl bash tar"
    ;;
esac

# 创建安装目录
mkdir -p "$INSTALL_DIR"

# 下载最新版本（stable）
DOWNLOAD_URL="https://github.com/0xJacky/nginx-ui/releases/latest/download/nginx-ui-linux-$ARCH_DL.tar.gz"
echo "下载: $DOWNLOAD_URL"
curl -L "$DOWNLOAD_URL" -o /tmp/nginx-ui.tar.gz

# 解压到 /opt/nginx-ui
tar -xzf /tmp/nginx-ui.tar.gz -C "$INSTALL_DIR"

# 创建默认配置文件
if [ ! -f "$CONFIG_FILE" ]; then
cat > "$CONFIG_FILE" <<EOF
[server]
Port = 9000
HTTPChallengePort = 9180
RunMode = release
EOF
fi

# 安装 systemd 服务文件
if command -v systemctl >/dev/null 2>&1; then
cat > /etc/systemd/system/nginx-ui.service <<EOF
[Unit]
Description=Nginx UI Service
After=network.target

[Service]
Type=simple
ExecStart=$BIN_FILE -config $CONFIG_FILE
Restart=on-failure
WorkingDirectory=$INSTALL_DIR
User=root

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable nginx-ui
echo "已安装 systemd 服务文件: /etc/systemd/system/nginx-ui.service"
fi

# 安装 OpenRC 服务文件（适用于 Alpine）
if command -v rc-update >/dev/null 2>&1; then
cat > /etc/init.d/nginx-ui <<EOF
#!/sbin/openrc-run

name="nginx-ui"
command="$BIN_FILE"
command_args="-config $CONFIG_FILE"
pidfile="/run/\${RC_SVCNAME}.pid"
command_background=true

depend() {
    need net
}
EOF

chmod +x /etc/init.d/nginx-ui
rc-update add nginx-ui default
echo "已安装 OpenRC 服务文件: /etc/init.d/nginx-ui"
fi

echo "✅ Nginx UI 安装完成"
echo "二进制文件: $BIN_FILE"
echo "配置文件: $CONFIG_FILE"
echo "启动方式: systemctl start nginx-ui 或 rc-service nginx-ui start"
