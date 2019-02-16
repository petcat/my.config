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
/etc/init.d/shadowsocks-r start | stop | restart | status
/etc/init.d/shadowsocks-r start | stop | restart | status
/etc/init.d/shadowsocks-r start | stop | restart | status
/etc/init.d/shadowsocks-r start | stop | restart | status

Shadowsocks-Go ：
/etc/init.d/shadowsocks-go start | stop | restart | status

Shadowsocks-libev ：
/etc/init.d/shadowsocks-libev start | stop | restart | status
