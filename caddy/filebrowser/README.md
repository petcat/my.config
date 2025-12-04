## 安装
`curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash`   

## 设置
新设置，设置端口然后新增用户名和密码
```
./filebrowser config init --address 0.0.0.0 --port 8090 --locale zh-cn --log /var/log/filebrowser.log
./filebrowser users add admin YOu#Pass911# --perm.admin
# 统一 /opt/filebrowser 目录
/opt/filebrowser/filebrowser -d /opt/filebrowser/filebrower.db config init --address 0.0.0.0 --port 8090 --locale zh-cn --log /var/log/filebrowser.log
/opt/filebrowser/filebrowser -d /opt/filebrowser/filebrower.db users add aming K7078608Ddef3418 --perm.admin
```

已存在filebrowser.db
```
./filebrowser config set --address 0.0.0.0 --port 8090 --locale zh-cn --log /var/log/filebrowser.log
./filebrowser users update admin -p YOu#Pass911#
```

## 说明
创建配置数据库：`filebrowser -d /etc/filebrowser.db config init`   
设置监听地址：`filebrowser -d /etc/filebrowser.db config set --address 0.0.0.0`    
设置监听端口：`filebrowser -d /etc/filebrowser.db config set --port 8088`    
设置语言环境：`filebrowser -d /etc/filebrowser.db config set --locale zh-cn`     
设置日志位置：`filebrowser -d /etc/filebrowser.db config set --log /var/log/filebrowser.log`     
设置默认目录：`filebrowser -d /etc/filebrowser.db config set --scope /srv`    
设置默认网址：`filebrowser -d /etc/filebrowser.db config set --baseurl https://xxxxx`   
添加验证码：`filebrowser -d /etc/filebrowser.db config set --auth.method=json --recaptcha.key XXXXXXX --recaptcha.secret XXXXXXX`   
国内用户使用：`filebrowser -d /etc/filebrowser.db config set --recaptcha.host https://recaptcha.net`   
//关闭验证码：`filebrowser -d /etc/filebrowser.db config set --recaptcha null`   
添加一个用户：`filebrowser -d /etc/filebrowser.db users add root password --perm.admin`      
其中的root和password分别是用户名和密码，根据自己的需求更改。    


## 开机启动（systemd）：   

> /etc/systemd/system 用于本地安装      
> /lib/systemd/system/ 用于包安装     
> ~~wget -O /lib/systemd/system/filebrowser.service https://raw.githubusercontent.com/petcat/my.config/master/caddy/filebrowser/filebrowser.service~~   

`wget -O /etc/systemd/system/filebrowser.service https://raw.githubusercontent.com/petcat/my.config/master/caddy/filebrowser/filebrowser.service`

`wget -O /etc/systemd/system/filebrowser.service https://git.io/Je3Q7`   

开机启动：`systemctl enable filebrowser.service`   

修改：`nano /etc/systemd/system/filebrowser.service`  

修改完成后：`systemctl daemon-reload`   

取消开机启动：`systemctl disable filebrowser.service` 

## 开机启动 (/etc/rc.local):

setsid /usr/local/bin/filebrowser -d /etc/filebrowser.db &   

## 命令

运行：`systemctl start filebrowser`   

停止：`systemctl stop filebrowser`     

查看运行状态：`systemctl status filebrowser`   

