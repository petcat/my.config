`wget -O /etc/systemd/system/cloudreve.service https://raw.githubusercontent.com/petcat/my.config/master/caddy/Cloudreve/cloudreve.service`

`systemctl enable cloudreve`

# 启动服务
systemctl start cloudreve

# 停止服务
systemctl stop cloudreve

# 重启服务
systemctl restart cloudreve

# 查看状态
systemctl status cloudreve
