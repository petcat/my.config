## KVM
Debian（debian-10 x64）    
https://github.com/bontibon/digitalocean-alpine    

wget https://github.com/bontibon/digitalocean-alpine/raw/master/digitalocean-alpine.sh    
chmod +x digitalocean-alpine.sh    
./digitalocean-alpine.sh --rebuild     


## OpenVZ 
wget https://raw.githubusercontent.com/petcat/my.config/master/alpine.sh     
bash alpine.sh    
sh alpine.sh   


wget -O /etc/profile --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/alpine/profile && source /etc/profile    


http://images.linuxcontainers.org//images/alpine/3.9/amd64/default/20200303_13:00//rootfs.tar.xz     
http://images.linuxcontainers.org/meta/1.0/index-system     


---
## caddy自启

`rc-update add caddy boot`


或添加 `/etc/local.d/xxx.start` 自启文档，内容为 `/etc/init.d/caddy start` ，然后执行命令： `rc-update add local`


### Aria2c 自启
```
mkdir -p /etc/aria2 && touch /etc/aria2/aria2.session
wget -O /etc/aria2/aria2.conf --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/aria2.conf
touch /etc/local.d/aria2c.start 
echo /usr/bin/aria2c --conf-path=/etc/aria2/aria2.conf -D > /etc/local.d/aria2c.start
chmod +x /etc/local.d/aria2c.start 
rc-update add local
```
