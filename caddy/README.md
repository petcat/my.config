caddy 安装 

`curl https://getcaddy.com | bash -s personal hook.service,http.cache,http.cgi,http.filebrowser,http.git,http.upload,http.webdav,tls.dns.cloudflare`

`curl https://getcaddy.com | bash -s personal hook.service,http.cache,http.cgi,http.filebrowser,http.git,http.upload,http.webdav,tls.dns.cloudflare,tls.dns.digitalocean`

`curl https://getcaddy.com | bash -s personal hook.service,http.cache,http.filebrowser,http.git,tls.dns.cloudflare`

caddy自启
`caddy -service install -agree -email money@189.cn -conf /usr/local/bin/Caddyfile`

配置 Caddyfile
`wget -O /usr/local/bin/Caddyfile https://raw.githubusercontent.com/petcat/my.config/master/caddy/Caddyfile`

caddy + PHP

```
# PHP-FPM Configuration for Caddy
     fastcgi / /run/php/php7.0-fpm.sock php {
         ext .php
         split .php
         index index.php
     }
```

`fastcgi / 127.0.0.1:9000 php`
