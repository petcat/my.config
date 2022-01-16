## sshd_config
```
Port 10000      
AuthorizedKeysFile      %h/.ssh/authorized_keys  %h/.ssh/authorized_keys2      
PasswordAuthentication no  
```
## authorized_keys

```
# 创建
mkdir /root/.ssh && chmod 600 /root/.ssh && touch /root/.ssh/authorized_keys /root/.ssh/authorized_keys2 && chmod 700 /root/.ssh/*  
 
# 下载 --no-check-certificate
wget -O .ssh/authorized_keys https://raw.githubusercontent.com/petcat/my.config/master/ssh/25519
wget -O .ssh/authorized_keys2 https://raw.githubusercontent.com/petcat/my.config/master/ssh/default
wget -O .ssh/authorized_keys https://raw.githubusercontent.com/petcat/my.config/master/ssh/new
```

```
mkdir -p /root/.ssh && chmod 600 /root/.ssh && wget -O /root/.ssh/authorized_keys --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/ssh/25519 && chmod 700 /root/.ssh/authorized_keys
```

## 其他    
### 修改端口、禁止密码登陆   
```
sed -i 's/^#\?Port 22/Port 10000/' /etc/ssh/sshd_config
sed -i 's/^#\?PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config 
sed -i 's/^#\?AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config 
systemctl restart ssh
# 报错 sshd error: no more sessions
sed -i 's/^#\?MaxSessions 10/MaxSessions 20/' /etc/ssh/sshd_config
# 开启 root 登录（甲骨文、谷歌云）
sed -i 's/^#\?PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
###
sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
```
sed -i 's/#AuthorizedKeysFile .ssh/authorized_keys/AuthorizedKeysFile .ssh/authorized_keys/' /etc/ssh/sshd_config
sed -i 's/#AuthorizedKeysFile .ssh/authorized_keys .ssh/authorized_keys2/AuthorizedKeysFile .ssh/authorized_keys .ssh/authorized_keys2/' /etc/ssh/sshd_config

```
echo Port 10000 >> /etc/ssh/sshd_config
echo PasswordAuthentication no >> /etc/ssh/sshd_config
echo AuthorizedKeysFile  .ssh/authorized_keys .ssh/authorized_keys2 >> /etc/ssh/sshd_config
```
