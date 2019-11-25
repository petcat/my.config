## 安装

`bash <(curl -L -s https://install.direct/go.sh)`   

`wget -O /etc/v2ray/config.json https://raw.githubusercontent.com/petcat/my.config/master/v2ray/config.json`   

```
12345   
7c3b0050-df4a-4ea4-a9a2-9e4959c4c654    
```
---

```
{
  "inbounds": [
    {
      "port": 10000,
      "listen":"127.0.0.1",
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "b831381d-6324-4d53-ad4f-8cda48b30811",
            "alterId": 64
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
        "path": "/go"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}
```

```
mydomain.xyz {
    proxy /go  localhost:10000 {
    websocket
    header_upstream -Origin
  }
}
```
