caddy 安装 

`curl https://getcaddy.com | bash -s personal hook.service,http.cache,http.cgi,http.filebrowser,http.git,http.upload,http.webdav,tls.dns.cloudflare`

`curl https://getcaddy.com | bash -s personal hook.service,http.cache,http.filebrowser,http.git,tls.dns.cloudflare`

caddy自启
`caddy -service install -agree -email my@vpshost.cc -conf /usr/local/bin/Caddyfile`
