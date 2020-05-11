https://trojan-tutor.github.io/2019/04/10/p41.html    

https://github.com/trojan-gfw/   

```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/trojan-gfw/trojan-quickstart/master/trojan-quickstart.sh)"
```

systemctl enable trojan  
systemctl status trojan   
systemctl start trojan   

nano /usr/local/etc/trojan/config.json  修改 password 证书
```
/root/.caddy/acme/acme-v02.api.letsencrypt.org/sites/123.com/123.com.crt
/root/.caddy/acme/acme-v02.api.letsencrypt.org/sites/123.com/123.com.key
```

```
z.xyz  {
  tls  lighttpd@hotmail.com
  proxy  /  https://www.ietf.org
}
```

```
server {
    listen 127.0.0.1:80 default_server;

    server_name <tdom.ml>;

    location / {
        proxy_pass https://www.ietf.org;
    }

}

server {
    listen 127.0.0.1:80;

    server_name <10.10.10.10>;

    return 301 https://<tdom.ml>$request_uri;
}

server {
    listen 0.0.0.0:80;
    listen [::]:80;

    server_name _;

    return 301 https://$host$request_uri;
}
```
