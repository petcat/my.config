## 日志占用及清理   

`du -h /var/log`  
`journalctl --disk-usage`  
`du -h --max-depth=1 /`

```
# 清理7天之前的日志
journalctl --vacuum-time=7d
# 清理2小时之前的日志
journactl --vacuum-time=2h
# 清理10秒之前的日志
journalctl --vacuum-time=10s
###
# 限制systemd日志占用不超过1G空间
journalctl --vacuum-size=1G
# 限制systemd日志占用不超过100M
journalctl --vacuum-size=100M
###
# 保留最近的5个日志文件
journalctl --vacuum-files=5
```

### 修改配置
`nano /etc/systemd/journald.conf`

```
# 限制500M
SystemMaxUse=500M
systemctl restart systemd-journald
```
`sed -i 's/^#\?SystemMaxUse=/SystemMaxUse=500M/' /etc/systemd/journald.conf`

### 直接停用日志
```
systemctl stop syslog.socket rsyslog.service 
systemctl disable rsyslog.service 
systemctl status rsyslog 
```
