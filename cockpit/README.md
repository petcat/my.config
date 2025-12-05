### ubuntu 22.04/24.04

```
# 添加源
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_$(lsb_release -rs)/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
```
```
# 导入 key
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_$(lsb_release -rs)/Release.key | sudo apt-key add -
```
# 更新并安装
apt update
apt install cockpit-podman

## debian 12

```
echo "deb http://deb.debian.org/debian bookworm-backports main" | tee /etc/apt/sources.list.d/backports.list
sudo apt update
sudo apt -t bookworm-backports install podman cockpit-podman
```
