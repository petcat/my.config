## 导入密钥

Compute Engine ---- 元数据 ----- SSH 密钥，用户名就是登陆用户名

使用密钥登陆，复制密钥给 root 使用，并切换 root

`sudo cp -r .ssh /root` 
 `sudo -i`

### 开启 root 登陆

`sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config`

### 修改端口，要在防火墙增加放行端口
```
sed -i 's/^#\?Port 22/Port 10000/' /etc/ssh/sshd_config
sed -i 's/^#\?PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config 
```

### 删除多余的 Google 进程和用户
```
apt purge google*
userdel -r xxx
```
