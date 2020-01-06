aria2c --conf-path=/etc/aria2/aria2.conf -D

mkdir -p /etc/aria2 && touch /etc/aria2/aria2.session  

`wget -O /etc/aria2/aria2.conf --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/aria2.conf`

`wget -O /etc/systemd/system/aria2c.service --no-check-certificate https://raw.githubusercontent.com/petcat/my.config/master/tools/aria2/aria2c.service`
