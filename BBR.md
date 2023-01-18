# 命令：
`echo "net.core.default_qdisc = fq" >> /etc/sysctl.conf && echo "net.ipv4.tcp_congestion_control = bbr" >> /etc/sysctl.conf && sysctl -p`

## 检测
`lsmod | grep bbr`
