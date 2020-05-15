# 安装Caddy 

`curl -OL "https://github.com/caddyserver/caddy/releases/latest/download/ASSET`

https://caddyserver.com/docs/download
```
# debian
echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" \ | tee -a /etc/apt/sources.list.d/caddy-fury.list
apt update
apt install caddy
```

```
# centos
yum install yum-plugin-copr
yum copr enable @caddy/caddy
yum install caddy
```
```
# 建立用户组及用户
groupadd --system caddy
useradd --system --gid caddy --create-home --home-dir /var/lib/caddy --shell /usr/sbin/nologin --comment "Caddy web server" caddy
```
