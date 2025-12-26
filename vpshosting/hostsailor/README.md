LA IPv6设置

mcedit /etc/network/interfaces
```
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

iface eth0 inet6 static
    address 2a0e:df40:3:16:16::
    netmask 64
    gateway 2a0e:df40:3::1

    up ip -6 addr add 2a0e:df40:3:16::16/64 dev eth0
    up ip -6 addr add 2a0e:df40:3:16::2/64 dev eth0
```
---


   _____ __              __                              __       
  / ___// /_  ____ _____/ /___ _      ___________  _____/ /_______
  \__ \/ __ \/ __ `/ __  / __ \ | /| / / ___/ __ \/ ___/ //_/ ___/
 ___/ / / / / /_/ / /_/ / /_/ / |/ |/ (__  ) /_/ / /__/ ,< (__  ) 
/____/_/ /_/\__,_/\__,_/\____/|__/|__/____/\____/\___/_/|_/____/  
_______________________________________________________________

                Welcome to Alpine! [/etc/motd]
       ++++++++++++++++++++++++++++++++++++++++++++++                                                                  
        IP: 185.45.195.246 [2a0e:df40:3:16:16::]
        apk add frp 
nano /ets/shadowsocks-rust.json
rc-service shadowsocks start
rc-service shadowsocks status
rc-service shadowsocks restart
升级：
nano /etc/apk/repositories
apk upgrade shadowsocks-rust --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main
apk upgrade frp --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
20443, 20444, 44433

Nginx: /var/www/html 
_________________________________________________________________
