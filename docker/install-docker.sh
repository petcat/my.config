#!/usr/bin/env bash
set -e
# 更新系统
apt update && apt upgrade -y
# 安装依赖
apt install -y ca-certificates curl gnupg lsb-release
# 添加 Docker 官方 GPG 密钥
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | \
  gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# 添加 Docker 官方仓库
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
  > /etc/apt/sources.list.d/docker.list

# 更新并安装 Docker 引擎
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 启动并设置开机自启
systemctl enable docker
systemctl start docker

# 验证安装
docker --version
echo "✅ Docker 已安装并启动成功！"
