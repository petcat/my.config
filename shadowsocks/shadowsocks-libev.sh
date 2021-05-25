#!/bin/bash
#Set shadowsocks server port
echo "Please shadowsocks server port:"
read -t 30 -p "(Default: 9999):" SS_PORT
if [ "$SS_PORT" = "" ]; then
SS_PORT="9999"
fi
echo "shadowsocks server port:$SS_PORT"
echo "####################################"

#Set shadowsocks server password
echo "Please shadowsocks server password:"
read -t 30 -p "(Default: ss):" SS_PASSWORD
if [ "$SS_PASSWORD" = "" ]; then
SS_PASSWORD="A9cF9aFFbB11c72c"
fi
echo "shadowsocks server Password:$SS_PASSWORD"
echo "####################################"

sudo apt-get update
sudo apt-get install -y snapd
sudo snap install shadowsocks-libev --edge

cat <<END >/var/snap/shadowsocks-libev/config.json
{
    "server": "0.0.0.0",
    "server_port":"${SS_PORT}",
    "password":"${SS_PASSWORD}",
    "timeout": 300,
    "method":"aes-256-gcm",
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp"
}
END

cat <<END >/etc/systemd/system/shadowsocks-libev.service
[Unit]
  Description=Shadowsocks-Libev Server
  After=network-online.target
   
[Service]
  Type=simple
  ExecStart=/usr/bin/snap run shadowsocks-libev.ss-server -c /var/snap/shadowsocks-libev/config.json
  Restart=always
  RestartSec=2
   
[Install]
WantedBy=multi-user.target
END

#Start SS Server
systemctl enable shadowsocks-libev.service
systemctl start shadowsocks-libev.service
echo "======================================"
echo "1. start the service: systemctl start shadowsocks-libev.service"
echo "2. check the status: systemctl status shadowsocks-libev.service"
echo "3. config file is here: /var/snap/shadowsocks-libev/config.json"
echo "4. update shadowsocks: snap refresh shadowsocks-libev --edge"
echo "======================================"
