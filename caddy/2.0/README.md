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
