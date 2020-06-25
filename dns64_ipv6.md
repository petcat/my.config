<http://www.trex.fi/2011/dns64.html>

```
# /etc/resolv.conf
nameserver 2001:67c:2b0::4
nameserver 2001:67c:2b0::6
#
# Command
echo nameserver 2001:67c:2b0::4 >> /etc/resolv.conf && echo nameserver 2001:67c:2b0::6 >> /etc/resolv.conf
```

