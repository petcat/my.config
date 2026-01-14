#!/bin/bash

#############################################
#   VPS 初始化脚本（混合模式：非关键步骤容错）
#############################################

set -e  # 关键步骤失败立即退出
ERRORS=()  # 用于记录非关键步骤错误

# --- 可配置变量 ---
KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHU4I+uqyj6l254xb2LjyO/STXpf2m0lraFGf/8MPFUq"
APP="screen apt-transport-https ca-certificates zstd mc curl zip unzip nano"
ALIASES_URL="https://raw.githubusercontent.com/petcat/my.config/refs/heads/master/ssh/.my_aliases"

echo "开始 VPS 初始化..."

#############################################
# 0. 检测系统类型
#############################################
if [ -f /etc/debian_version ]; then
    OS="debian"
elif [ -f /etc/lsb-release ]; then
    OS="ubuntu"
else
    OS="unknown"
fi
echo "检测到系统: $OS"

#############################################
# 1. 系统更新（关键步骤）
#############################################
echo "更新系统..."
apt update && apt upgrade -y

#############################################
# 2. 安装软件（关键步骤）
#############################################
echo "安装软件: $APP"
apt install -y $APP

# 确保 wget/curl 存在
if ! command -v wget >/dev/null 2>&1 && ! command -v curl >/dev/null 2>&1; then
    apt install -y wget curl
fi

#############################################
# 3. SSH 密钥配置（关键步骤）
#############################################
if [ -n "$KEY" ]; then
    echo "配置 SSH 密钥认证..."

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

    # 自动检测 SSH 服务名
    if systemctl list-unit-files | grep -q ssh.service; then
        systemctl restart ssh
    else
        systemctl restart sshd
    fi

else
    echo "警告: 未设置 SSH 公钥，跳过密钥配置。"
fi

#############################################
# 4. 设置 .profile（非关键步骤）
#############################################
echo "设置 .profile..."
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

#############################################
# 5. 下载 .my_aliases（关键步骤）
#############################################
if [ -n "$ALIASES_URL" ]; then
    echo "下载 .my_aliases..."
    if command -v wget >/dev/null 2>&1; then
        wget -O /root/.my_aliases "$ALIASES_URL" || exit 1
    else
        curl -o /root/.my_aliases "$ALIASES_URL" || exit 1
    fi
    chmod 644 /root/.my_aliases
fi

#############################################
# 6. 启用 BBR（非关键步骤）
#############################################
echo "启用 BBR..."
kernel_version=$(uname -r | cut -d'-' -f1)
if dpkg --compare-versions "$kernel_version" ge "4.9"; then
    {
        grep -q "net.core.default_qdisc=fq" /etc/sysctl.conf || echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
        grep -q "net.ipv4.tcp_congestion_control=bbr" /etc/sysctl.conf || echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
        sysctl -p
    } || ERRORS+=("BBR 配置失败")
else
    ERRORS+=("内核版本过低，不支持 BBR")
fi

#############################################
# 7. 日志系统优化（非关键步骤）
#############################################

# journald
echo "配置 journald..."
{
    JOURNALD_CONF="/etc/systemd/journald.conf"
    cp "$JOURNALD_CONF" "${JOURNALD_CONF}.bak"

    sed -i 's/^#*SystemMaxUse=.*/SystemMaxUse=32M/' "$JOURNALD_CONF"
    sed -i 's/^#*SystemKeepFree=.*/SystemKeepFree=64M/' "$JOURNALD_CONF"
    sed -i 's/^#*SystemMaxFileSize=.*/SystemMaxFileSize=4M/' "$JOURNALD_CONF"

    if grep -q "SystemMaxFiles" "$JOURNALD_CONF"; then
        sed -i 's/^#*SystemMaxFiles=.*/SystemMaxFiles=5/' "$JOURNALD_CONF"
    fi

    systemctl restart systemd-journald
} || ERRORS+=("journald 配置失败")

# rsyslog
echo "配置 rsyslog..."
{
    if command -v rsyslogd >/dev/null 2>&1; then
        cp /etc/rsyslog.conf /etc/rsyslog.conf.bak
        systemctl restart rsyslog
    fi
} || ERRORS+=("rsyslog 配置失败")

# logrotate
echo "配置 logrotate..."
{
    cat > /etc/logrotate.d/vps_optimization << 'EOF'
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
    logrotate -f /etc/logrotate.conf
} || ERRORS+=("logrotate 执行失败")

#############################################
# 8. motd 替换（非关键步骤）
#############################################
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
if [ -f "$SCRIPT_DIR/motd" ]; then
    cp "$SCRIPT_DIR/motd" /etc/motd || ERRORS+=("motd 替换失败")
fi

#############################################
# 9. 执行同目录脚本（非关键步骤）
#############################################
echo "执行其他脚本..."
for script in "$SCRIPT_DIR"/*.sh; do
    [ "$script" = "$0" ] && continue
    chmod +x "$script"
    ( "$script" ) || ERRORS+=("脚本 $script 执行失败")
done

#############################################
# 10. 最终报告
#############################################
echo ""
echo "=============================="
echo "  VPS 初始化完成"
echo "=============================="

if [ ${#ERRORS[@]} -gt 0 ]; then
    echo "以下非关键步骤执行失败："
    printf ' - %s\n' "${ERRORS[@]}"
else
    echo "所有步骤均成功执行。"
fi

echo "初始化结束。"
