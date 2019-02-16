### Installl:
```
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh && chmod +x shadowsocks-all.sh && ./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
```

### Reinstall
`./shadowsocks-all.sh uninstall`

### Config file:
```
/etc/shadowsocks-python/config.json

/etc/shadowsocks-r/config.json

/etc/shadowsocks-go/config.json

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
