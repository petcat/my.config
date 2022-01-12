# 网盘

## Alist  
https://github.com/Xhofe/alist/releases

`wget https://github.com/Xhofe/alist/releases/download/v2.0.5-libc/alist-linux-amd64.tar.gz`

`/usr/lib/systemd/system/alist.service`  /usr/local/bin/alist -conf /etc/alist/config.json  

`wget -O /usr/lib/systemd/system/alist.service https://raw.githubusercontent.com/petcat/my.config/master/netdrive/alist/alist.service`


然后systemctl daemon-reload，现在你就可以使用这些命令来管理程序了：  

启动: systemctl start alist   
关闭: systemctl stop alist    
自启: systemctl enable alist    
状态: systemctl status alist   
重启: systemctl restart alist   

```
[Unit]
Description=alist
After=network.target
 
[Service]
Type=simple
WorkingDirectory=path_alist
ExecStart=path_alist/alist-xxxx -conf data/config.json
Restart=on-failure
 
[Install]
WantedBy=multi-user.target
```
