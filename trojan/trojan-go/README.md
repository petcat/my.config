
-----------------------------------
## 新建临时目录：
`mkdir trojan`   

## 下载并解压 
https://github.com/p4gefau1t/trojan-go/releases  
`wget https://github.com/p4gefau1t/trojan-go/releases/download/v0.10.6/trojan-go-linux-amd64.zip && unzip trojan-go-linux-amd64.zip`

### 目录结构
```
├── example
│   ├── client.json    --客户端
│   ├── client.yaml    --客户端
│   ├── server.json    --服务端
│   ├── server.yaml    --服务端
│   ├── trojan-go.service  --自启服务
│   └── trojan-go@.service
├── geoip.dat  --路由
├── geoip-only-cn-private.dat   --路由
├── geosite.dat   --路由
├── trojan-go    --主程序
└── trojan-go-linux-amd64.zip --压缩包
```
可以清楚看到，已经都齐备。只需要修改一下就能用。

## 再新建目录：
`mkdir /etc/trojan-go/`  
`mkdir /usr/share/trojan-go/`  

## 归档主程序、路由、服务端、自启
`mv trojan-go /usr/bin/`  
`mv geo* /usr/share/trojan-go/`  
`mv example/server.json /etc/trojan-go/config.json`  
`mv example/trojan-go.service /etc/systemd/system`  

## 修改配置
### 自启配置，基本不用修改
`nano /etc/systemd/system/trojan-go.service`
### 服务端配置，需要修改成自己
`nano /etc/trojan-go/config.json`

备注：使用caddy 证书目录 `/var/lib/caddy/.local/share/caddy/certificates/acme.zerossl.com-v2-dv90/xxxx.com`

```
启动: systemctl start trojan-go
状态: systemctl status trojan-go
开机自启：systemctl enable trojan-go
取消启动：systemctl disable trojan-go
```
