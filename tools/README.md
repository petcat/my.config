Youtube-dl   
`curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl && chmod a+rx /usr/local/bin/youtube-dl`

aria2   
`aria2c --enable-rpc --rpc-listen-all=true --rpc-allow-origin-all --rpc-secret=112121 --dir=/www/down -D`

Tools  
`apt install -y mc zip unzip htop aria2 axel screen lrzsz git lftp nano ffmpeg curl p7zip`

RAR  
```
# 64
wget https://rarlab.com/rar/rarlinux-x64-5.7.1.tar.gz && tar xzf rarlinux*.tar.gz && cd rar && make && cd .. && mv rar* /tmp 
# 86
wget https://rarlab.com/rar/rarlinux-5.7.1.tar.gz && tar xzf rarlinux*.tar.gz && cd rar && make && cd .. && mv rar* /tmp
```
