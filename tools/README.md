Youtube-dl   
`curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl && chmod a+rx /usr/local/bin/youtube-dl`

aria2   
`aria2c --enable-rpc --rpc-listen-all=true --rpc-allow-origin-all --rpc-secret=112121 --dir=/www/down -D`

Tools  
`apt install -y mc zip unzip htop aria2 axel screen lrzsz git lftp nano ffmpeg curl`

RAR  
```
wget http://rarlab.com/rar/rarlinux-x64-5.5.0.tar.gz && tar xzf rarlinux*.tar.gz && cd rar && make && cd .. && mv rarlinux*.tar.gz rar /tmp   
wget http://rarlab.com/rar/rarlinux-5.5.0.tar.gz && tar xzf rarlinux*.tar.gz && cd rar && make && cd .. && mv rarlinux*.tar.gz rar /tmp
```
