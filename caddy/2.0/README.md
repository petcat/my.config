## 安装Caddy 

`curl -OL "https://github.com/caddyserver/caddy/releases/latest/download/ASSET`

https://caddyserver.com/docs/download
```
# debian
# apt install apt-transport-https
echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" | tee -a /etc/apt/sources.list.d/caddy-fury.list
apt update
apt install caddy
```

```
# centos
yum install yum-plugin-copr
yum copr enable @caddy/caddy
yum install caddy
```

## 命令
/usr/bin/caddy ,  /etc/caddy/Caddyfile ,   /usr/share/caddy/index.html
```
systemctl status caddy
systemctl start caddy
systemctl stop caddy
systemctl reload caddy
```
## Caddyfile 例子 

`wget -O /etc/caddy/Caddyfile https://raw.githubusercontent.com/petcat/my.config/master/caddy/2.0/Caddyfile`   

```
iname.com, www.iname.com  {
        root * /www/iname.com/public
        file_server
        tls  lighttpd@hotmail.com
        encode zstd gzip
}
i.pp.ua { 
        tls lighttpd@hotmail.com 
        reverse_proxy  127.0.0.1:12345  
}
:88 {
        root * /srv/down
        file_server  browse
        encode gzip
}
```

#### 合并公用
```
{
        email  freessl@outlook.com
}
iname.com, www.iname.com  {
        root * /www/iname.com/public
        file_server
        encode zstd gzip
}
i.pp.ua { 
        reverse_proxy  127.0.0.1:12345  
}
:8080 {
        root * /srv/
        file_server  browse
        encode zstd gzip
}
# php_fastcgi unix//run/php/php7.4-fpm.sock
# php_fastcgi 127.0.0.1:9000
# php_fastcgi localhost:9005
```


--已过时--
----
### 建立用户组及用户（已过时）
```
groupadd --system caddy
useradd --system --gid caddy --create-home --home-dir /var/lib/caddy --shell /usr/sbin/nologin --comment "Caddy web server" caddy
```

### 注册成为服务 （已过时）
```
#下载
wget -O /etc/systemd/system/caddy.service https://raw.githubusercontent.com/caddyserver/dist/master/init/caddy.service
# 自启服务
systemctl enable caddy
# 修改后重加载
systemctl daemon-reload
# 命令
systemctl status caddy
systemctl start caddy
systemctl stop caddy
systemctl reload caddy
```
