## 安装

新版本： https://github.com/v2fly/fhs-install-v2ray/blob/master/README.zh-Hans-CN.md    

```
# 安装v2   
bash <(curl -L -s https://install.direct/go.sh)     
# 下载配置   
wget -O /etc/v2ray/config.json https://raw.githubusercontent.com/petcat/my.config/master/v2ray/config.json  
# 重启v2及状态   
service v2ray restart  
service v2ray status
```
~~12345   7c3b0050-df4a-4ea4-a9a2-9e4959c4c654~~    
> 12345   12971686-6db1-49ea-bddc-2bbef15819d6

##### Nginx配置
`wget -O /etc/nginx/conf.d/v2ray.conf --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/v2ray/nginx.conf`

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
my.xyz {
    tls    z@163.com
    proxy /  127.0.0.1:12345  {
    websocket
    header_upstream -Origin
  }
}
```
