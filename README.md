# my.config

https://raw.githubusercontent.com/petcat/my.config/master/.bashrc
https://raw.githubusercontent.com/petcat/my.config/master/alpine.sh

`wget -O .bashrc --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/bashrc && source ~/.bashrc`  

`wget -O /etc/profile --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/bashrc && source /etc/profile`    

`wget -O alpine.sh --no-check-certificate https://git.io/fhNiF && bash alpine.sh`

### BBR：    
`wget -O /etc/sysctl.conf --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/sysctl.conf && sysctl -p && lsmod | grep bbr`

Welcome:
`/etc/update-motd.d/10-help-text`

`wget -O /etc/aria2/aria2.conf --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/aria2.conf`

### phpmyadmin
`wget -O libraries/config.default.php --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/phpmyadmin.php`
