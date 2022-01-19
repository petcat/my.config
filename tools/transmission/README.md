## 安装
```
apt update 
apt install software-properties-common -y
add-apt-repository ppa:transmissionbt/ppa 
apt update && apt install transmission-daemon -y  
```

wget -O /etc/transmission-daemon/settings.json https://raw.githubusercontent.com/petcat/my.config/master/tools/transmission/settings.json


### 命令
```
service transmission-daemon start  
service transmission-daemon stop 
service transmission-daemon status
```

### 美化  
https://github.com/ronggang/transmission-web-control  

```
wget https://github.com/ronggang/transmission-web-control/raw/master/release/install-tr-control-cn.sh
chmod +x install-tr-control-cn.sh && bash install-tr-control-cn.sh
```
