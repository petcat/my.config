## aria2.session
mkdir -p /etc/aria2 && touch /etc/aria2/aria2.session  

## 下载aria2c配置文件

自用
`wget -O /etc/aria2/aria2.conf --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/tools/aria2/aria2.conf`

公用 aria2c.cn
`wget -O /etc/aria2/aria2.conf --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/aria2.conf`

## 注册成为 aria2c 服务
`wget -O /etc/systemd/system/aria2c.service --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/tools/aria2/aria2c.service`

## 使用命令：  

开机启动：systemctl enable aria2c  

运行：systemctl start aria2c    

停止：systemctl stop aria2c    

查看状态：systemctl status aria2c      

取消开机启动：systemctl disable aria2c    

--过时，弃用--  
aria2c --conf-path=/etc/aria2/aria2.conf -D
