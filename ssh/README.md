```
Port 10000      
AuthorizedKeysFile      %h/.ssh/authorized_keys  %h/.ssh/authorized_keys2      
PasswordAuthentication no  
```

```
sed -i 's/^#\?Port 22/Port 10000/' /etc/ssh/sshd_config
sed -i 's/^#\?PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config 

systemctl restart ssh
```
sed -i 's/#AuthorizedKeysFile .ssh/authorized_keys/AuthorizedKeysFile .ssh/authorized_keys/' /etc/ssh/sshd_config
sed -i 's/#AuthorizedKeysFile .ssh/authorized_keys .ssh/authorized_keys2/AuthorizedKeysFile .ssh/authorized_keys .ssh/authorized_keys2/' /etc/ssh/sshd_config

```
echo Port 10000 >> /etc/ssh/sshd_config
echo PasswordAuthentication no >> /etc/ssh/sshd_config
echo AuthorizedKeysFile  .ssh/authorized_keys .ssh/authorized_keys2 >> /etc/ssh/sshd_config
```
```
mkdir -p /root/.ssh && chmod 600 /root/.ssh && wget -O /root/.ssh/authorized_keys --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/ssh/new && chmod 700 /root/.ssh/authorized_keys
```

`wget -O /root/.ssh/authorized_keys --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/ssh/new`
