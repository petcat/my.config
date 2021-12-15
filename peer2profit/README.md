`wget -O /etc/systemd/system/peer2profit.service https://raw.githubusercontent.com/petcat/my.config/master/peer2profit/peer2profit.service`

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
