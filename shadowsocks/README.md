## 安装

## shadowsocks-rust

```
apt update
apt install -y snapd
apt install -y haveged
## Debian
snap install core 
snap install shadowsocks-rust
```

#### 配置文件


`mkdir -p /var/snap/shadowsocks-rust/common/etc/shadowsocks-rust`  
`wget -O /var/snap/shadowsocks-rust/common/etc/shadowsocks-rust/config.json https://raw.githubusercontent.com/petcat/my.config/master/shadowsocks/shadowsocks-rust/config.json`


### 使用
```
自启：snap start --enable shadowsocks-rust.ssserver-daemon
启动：snap start shadowsocks-rust.ssserver-daemon
重启：snap restart shadowsocks-rust.ssserver-daemon
停止：snap stop shadowsocks-rust.ssserver-daemon
状态：snap services shadowsocks-rust.ssserver-daemon
更新升级: snap refresh shadowsocks-rust
     systemctl status snap.shadowsocks-rust.ssserver-daemon.service
```


---
### shadowsocks-libev
```
apt update
apt install -y snapd
## Debian
~snap install core~ 
snap install shadowsocks-libev --edge
```

#### 配置文件
```
mkdir -p /var/snap/shadowsocks-libev/common/etc/shadowsocks-libev
wget -O /var/snap/shadowsocks-libev/common/etc/shadowsocks-libev/config.json https://raw.githubusercontent.com/petcat/my.config/master/shadowsocks/shadowsocks-libev/config.json
```
## 使用
```
自启：snap start --enable shadowsocks-libev.ss-server-daemon   
状态：systemctl status snap.shadowsocks-libev.ss-server-daemon.service   
重启：systemctl restart snap.shadowsocks-libev.ss-server-daemon.service   
启动：systemctl start snap.shadowsocks-libev.ss-server-daemon.service 
停止：systemctl stop snap.shadowsocks-libev.ss-server-daemon.service 
更新升级: snap refresh shadowsocks-libev --edge
```

#### 服务（旧）     

`wget -O /etc/systemd/system/shadowsocks-libev.service https://raw.githubusercontent.com/petcat/my.config/master/shadowsocks/shadowsocks-libev.service`



## 使用（旧）
```
1. 启动: systemctl start shadowsocks-libev
2. 状态: systemctl status shadowsocks-libev
3. 配置文件: /var/snap/shadowsocks-libev/config.json
4. 更新升级: snap refresh shadowsocks-libev --edge
5. 开机自启：systemctl enable shadowsocks-libev
6. 取消启动：systemctl disable shadowsocks-libev
---



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
1
---



