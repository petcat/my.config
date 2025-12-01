# 安装 docker 和 dpanel面板

```
wget https://raw.githubusercontent.com/petcat/my.config/refs/heads/master/docker/install-docker.sh && chmod +x install-docker.sh && ./install-docker.sh
```   

```
wget https://raw.githubusercontent.com/petcat/my.config/refs/heads/master/docker/install-dpanel.sh && chmod +x install-dpanel.sh && ./install-dpanel.sh
```   

## docker   

### jlesage/firefox   

VNC_PASSWORD 设置密码    
-e ENABLE_CJK_FONT=1 支持中文，    
或容器挂载系统字体，面板添加映射目录，只读，两边都是： /usr/share/fonts/opentype      
