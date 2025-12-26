LA IPv6设置

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
