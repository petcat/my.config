v2.x 版本   

https://github.com/petcat/my.config/tree/master/caddy/2.0    

v1.x 版本    

https://github.com/petcat/my.config/tree/master/caddy/1.0   


## upgrade 2.0
```
#删除
/etc/systemd/system/caddy.service && /usr/local/bin/caddy && /usr/local/bin/Caddyfile
/etc/systemd/system/multi-user.target.wants/caddy.service
/sys/fs/cgroup/systemd/system.slice/caddy.service

# 部分旧系统使用
/etc/init/caddy.conf 
```
