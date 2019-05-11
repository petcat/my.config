```
Port 10000      
AuthorizedKeysFile      .ssh/authorized_keys .ssh/authorized_keys2      
PasswordAuthentication no  
```

```
sed -i 's/Port 22/Port 10000/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config 

systemctl restart ssh
```
sed -i 's/#AuthorizedKeysFile .ssh/authorized_keys .ssh/authorized_keys2/AuthorizedKeysFile .ssh/authorized_keys .ssh/authorized_keys2/' /etc/ssh/sshd_config
