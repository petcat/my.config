# my.config


wget -O /root/.bashrc https://raw.githubusercontent.com/petcat/my.config/refs/heads/master/bashrc
https://raw.githubusercontent.com/petcat/my.config/master/alpine.sh

`wget -O .bashrc --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/bashrc && source ~/.bashrc`  


`wget -O alpine.sh --no-check-certificate https://git.io/fhNiF && bash alpine.sh`

### BBR：    
`wget -O /etc/sysctl.conf --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/sysctl.conf && sysctl -p && lsmod | grep bbr`

Welcome:
`/etc/update-motd.d/10-help-text`

`wget -O /etc/aria2/aria2.conf --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/aria2.conf`

### phpmyadmin
`wget -O libraries/config.default.php --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/phpmyadmin.php`

### open一键
`wget https://git.io/v1jlQ -O openvpn-install.sh && bash openvpn-install.sh`
