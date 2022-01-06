`wget -O /etc/systemd/system/peer2profit.service https://raw.githubusercontent.com/petcat/my.config/master/peer2profit/peer2profit.service`

`wget https://updates.peer2profit.com/p2pclient_0.56_amd64.deb`

开机自启：systemctl enable peer2profit

启动: systemctl start peer2profit

状态: systemctl status peer2profit


```
cat > /etc/systemd/system/peer2profit.service <<EOF
[Unit]
Description=peer2profit
After=network.target

[Service]
Type=simple
ExecStart=p2pclient --login virus110@gmail.com
RemainAfterExit=true
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
```
