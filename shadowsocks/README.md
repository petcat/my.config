## 安装

`wget https://raw.githubusercontent.com/petcat/my.config/master/shadowsocks/shadowsocks-libev.sh`

======================================
1. 启动: systemctl start shadowsocks-libev.service
2. 状态: systemctl status shadowsocks-libev.service
3. 配置文件: /var/snap/shadowsocks-libev/config.json
4. 更新升级: snap refresh shadowsocks-libev --edge
======================================



## BBR

#### 1、nano /etc/sysctl.conf
```
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr
```

OVZ 的 BBR

`curl https://raw.githubusercontent.com/linhua55/lkl_study/master/get-rinetd.sh | bash`     
/etc/rinetd-bbr.conf    
systemctl status rinetd-bbr.service    
systemctl restart rinetd-bbr.service   

https://github.com/tcp-nanqinlang/wiki/wiki/lkl-rinetd    

#### 2、重置网络 `sysctl -p`

#### 3、验证： `lsmod | grep bbr`

```
fs.file-max = 1000000
fs.inotify.max_user_instances = 8192
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_tw_reuse = 1
net.ipv4.ip_local_port_range = 1024 65000
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.tcp_max_tw_buckets = 6000
net.ipv4.route.gc_timeout = 100
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_synack_retries = 1
net.core.somaxconn = 32768
net.core.netdev_max_backlog = 32768
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_max_orphans = 32768
net.ipv4.ip_forward = 1
```


---
---



### Installl:
```
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh && chmod +x shadowsocks-all.sh && ./shadowsocks-all.sh
```

### Reinstall
`./shadowsocks-all.sh uninstall`

### Config file:
```
/etc/shadowsocks-python/config.json
wget -O /etc/shadowsocks-python/config.json https://raw.githubusercontent.com/petcat/my.config/master/shadowsocks/shadowsocks-python/config.json && /etc/init.d/shadowsocks-python restart

/etc/shadowsocks-r/config.json
wget -O /etc/shadowsocks-r/config.json https://raw.githubusercontent.com/petcat/my.config/master/shadowsocks/shadowsocks-r/config.json && /etc/init.d/shadowsocks-r restart

/etc/shadowsocks-go/config.json
wget -O /etc/shadowsocks-go/config.json https://raw.githubusercontent.com/petcat/my.config/master/shadowsocks/shadowsocks-go/config.json && /etc/init.d/shadowsocks-go restart

/etc/shadowsocks-libev/config.json
```

### Command

Shadowsocks-Python ：
```
/etc/init.d/shadowsocks-python status
/etc/init.d/shadowsocks-python start
/etc/init.d/shadowsocks-python restart
/etc/init.d/shadowsocks-python stop
```

ShadowsocksR ：
```
/etc/init.d/shadowsocks-r status
/etc/init.d/shadowsocks-r start
/etc/init.d/shadowsocks-r restart
/etc/init.d/shadowsocks-r stop
```
Shadowsocks-Go ：
```
/etc/init.d/shadowsocks-go status
/etc/init.d/shadowsocks-go start
/etc/init.d/shadowsocks-go restart
/etc/init.d/shadowsocks-go stop
```
Shadowsocks-libev ：
```
/etc/init.d/shadowsocks-libev status
/etc/init.d/shadowsocks-libev start
/etc/init.d/shadowsocks-libev restart
/etc/init.d/shadowsocks-libev stop
```

