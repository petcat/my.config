
```
wget --no-check-certificate -O /etc/systemd/system/rc-local.service https://raw.githubusercontent.com/petcat/my.config/master/autorun/rc-local.service

wget --no-check-certificate -O /etc/rc.local https://raw.githubusercontent.com/petcat/my.config/master/autorun/rc.local
```


chmod +x /etc/rc.local     
systemctl enable rc-local     


启动服务并检查状态    
systemctl start rc-local.service  
systemctl status rc-local.service  
