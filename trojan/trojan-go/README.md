/usr/share/trojan-go/geoip.dat
/usr/share/trojan-go/geosite.dat

/var/lib/caddy/.local/share/caddy/certificates/acme.zerossl.com-v2-dv90/xxxx.com


-----------------------------------
## 新建临时目录：
`mkdir trojan`   

## 下载并解压 https://github.com/p4gefau1t/trojan-go/releases
`wget https://github.com/p4gefau1t/trojan-go/releases/download/v0.10.6/trojan-go-linux-amd64.zip && unzip trojan-go-linux-amd64.zip`
```
├── example
│   ├── client.json
│   ├── client.yaml
│   ├── server.json
│   ├── server.yaml
│   ├── trojan-go.service
│   └── trojan-go@.service
├── geoip.dat
├── geoip-only-cn-private.dat
├── geosite.dat
├── trojan-go
└── trojan-go-linux-amd64.zip
```
可以清楚看到，已经都齐备。只需要修改一下就能用。

## 再新建目录：
`mkdir /etc/trojan-go/`  
`mkdir /usr/share/trojan-go/`  

## 归档主程序、路由、服务端、自启
`mv trojan-go /usr/bin/`  
`mv geo* /usr/share/trojan-go/`  
`mv example/server.json /etc/trojan-go/`  
`mv example/trojan-go.service /etc/systemd/system`  

## 修改配置
### 自启配置，基本不用修改
`nano /etc/systemd/system/trojan-go.service`
### 服务端配置，需要修改成自己
`nano /etc/trojan-go/server.json`

备注：使用caddy 证书目录 `/var/lib/caddy/.local/share/caddy/certificates/acme.zerossl.com-v2-dv90/xxxx.com`

