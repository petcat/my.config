https://github.com/Xhofe/alist/releases

`/usr/lib/systemd/system/alist.service`


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
