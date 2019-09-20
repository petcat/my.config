## 安装
`curl -fsSL https://filebrowser.xyz/get.sh | bash`   

## 开机启动（systemd）：   

`wget https://raw.githubusercontent.com/petcat/my.config/master/caddy/filebrowser/filebrowser.service -o /lib/systemd/system/filebrowser.service`   

开机启动：`systemctl enable filebrowser.service`   

更改完成后需要输入`systemctl daemon-reload`   

---
运行：`systemctl start filebrowser.service`   

停止：systemctl stop filebrowser.service   

取消开机启动：`systemctl disable filebrowser.service`   

查看运行状态：`systemctl status filebrowser.service`   
