#!/bin/bash

# --- 可配置变量 ---
KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHU4I+uqyj6l254xb2LjyO/STXpf2m0lraFGf/8MPFUq"
APP="screen apt-transport-https ca-certificates zstd mc curl zip unzip nano"
ALIASES_URL="https://raw.githubusercontent.com/petcat/my.config/refs/heads/master/ssh/.my_aliases"

set -e
echo "开始VPS初始化..."

# 检测系统类型
if [ -f /etc/debian_version ]; then
    OS="debian"
elif [ -f /etc/lsb-release ]; then
    OS="ubuntu"
else
    OS="unknown"
fi
echo "检测到系统: $OS"

# 1. 系统更新
apt update && apt upgrade -y

# 2. 安装软件
if [ -n "$APP" ]; then
    apt install -y $APP
fi

# 确保 wget 或 curl 存在
if ! command -v wget >/dev/null 2>&1 && ! command -v curl >/dev/null 2>&1; then
    apt install -y wget curl
fi

# 3. SSH 密钥认证
if [ -n "$KEY" ]; then
    echo "配置SSH密钥认证..."

    SSH_DIR="/root/.ssh"
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"

    echo "$KEY" >> "$SSH_DIR/authorized_keys"
    chmod 600 "$SSH_DIR/authorized_keys"

    SSH_CONFIG_FILE="/etc/ssh/sshd_config"
    cp "$SSH_CONFIG_FILE" "${SSH_CONFIG_FILE}.bak"

    sed -i 's/^#*PubkeyAuthentication.*/PubkeyAuthentication yes/' "$SSH_CONFIG_FILE"
    sed -i 's/^#*PermitRootLogin.*/PermitRootLogin yes/' "$SSH_CONFIG_FILE"
    sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' "$SSH_CONFIG_FILE"

    # Ubuntu 服务名为 ssh，Debian 为 sshd
    if systemctl list-unit-files | grep -q ssh.service; then
        systemctl restart ssh
    else
        systemctl restart sshd
    fi

    echo "SSH配置已更新。"
else
    echo "警告: 未设置SSH公钥，跳过密钥配置。"
fi

# 4. 设置 .profile
cat > /root/.profile << 'EOF'
export PATH="$HOME/bin:$PATH"
export HISTSIZE=5000

alias ls='ls -A --color=auto'
alias ll='ls -ahlF --color=auto'
alias lll='ls -lahFR --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias iprofile='source ~/.profile'
alias ialiases='nano ~/.my_aliases'

PS1="\033[33m[\t]\033[32m\u@\h:\033[34m\w\033[0m#"

[ -f ~/.my_aliases ] && . ~/.my_aliases
EOF

# 5. 下载 .my_aliases
if [ -n "$ALIASES_URL" ]; then
    echo "下载 .my_aliases..."
    if command -v wget >/dev/null 2>&1; then
        wget -O /root/.my_aliases "$ALIASES_URL"
    else
        curl -o /root/.my_aliases "$ALIASES_URL"
    fi
    chmod 644 /root/.my_aliases
fi

# 6. 启用 BBR
echo "启用BBR..."

kernel_version=$(uname -r | cut -d'-' -f1)
if dpkg --compare-versions "$kernel_version" ge "4.9"; then
    grep -q "net.core.default_qdisc=fq" /etc/sysctl.conf || echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
    grep -q "net.ipv4.tcp_congestion_control=bbr" /etc/sysctl.conf || echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
    sysctl -p
else
    echo "内核版本过低，不支持BBR。"
fi

# 7. 日志限制
echo "配置日志限制..."

JOURNALD_CONF="/etc/systemd/journald.conf"
if [ -f "$JOURNALD_CONF" ]; then
    cp "$JOURNALD_CONF" "${JOURNALD_CONF}.bak"

    sed -i 's/^#*SystemMaxUse=.*/SystemMaxUse=32M/' "$JOURNALD_CONF"
    sed -i 's/^#*SystemKeepFree=.*/SystemKeepFree=64M/' "$JOURNALD_CONF"
    sed -i 's/^#*SystemMaxFileSize=.*/SystemMaxFileSize=4M/' "$JOURNALD_CONF"

    # Debian 11 不支持 SystemMaxFiles
    if grep -q "SystemMaxFiles" "$JOURNALD_CONF"; then
        sed -i 's/^#*SystemMaxFiles=.*/SystemMaxFiles=5/' "$JOURNALD_CONF"
    fi

    systemctl restart systemd-journald
fi

# rsyslog
if command -v rsyslogd >/dev/null 2>&1; then
    RSYSLOG_CONF="/etc/rsyslog.conf"
    cp "$RSYSLOG_CONF" "${RSYSLOG_CONF}.bak"
    systemctl restart rsyslog
fi

# logrotate（安全模式）
LOGROTATE_VPS_FILE="/etc/logrotate.d/vps_optimization"
cat > "$LOGROTATE_VPS_FILE" << 'EOF'
# VPS优化: 限制常用日志文件大小
/var/log/syslog
/var/log/auth.log
/var/log/kern.log
{
    daily
    rotate 3
    compress
    delaycompress
    missingok
    notifempty
    maxsize 10M
    copytruncate
}
EOF

logrotate -f /etc/logrotate.conf || true

# 8. 替换 motd
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
if [ -f "$SCRIPT_DIR/motd" ]; then
    cp "$SCRIPT_DIR/motd" /etc/motd
fi

# 9. 执行同目录下其他脚本
echo "执行其他脚本..."
for script in "$SCRIPT_DIR"/*.sh; do
    [ "$script" = "$0" ] && continue
    chmod +x "$script"
    ( "$script" ) || echo "脚本 $script 执行失败，已跳过。"
done

echo "VPS初始化完成！"
