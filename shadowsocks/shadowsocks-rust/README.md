# 安装
```
curl https://sh.rustup.rs -sSf | sh
export PATH=$PATH:~/.cargo/bin
```

```
apt install cargo
cargo install shadowsocks-rust

mkdir /etc/shadowsocks-rust/
wget -O /etc/shadowsocks-rust/config.json https://raw.githubusercontent.com/petcat/my.config/master/shadowsocks/shadowsocks-rust/config.json
wget -O /etc/systemd/system/shadowsocks-rust.service https://raw.githubusercontent.com/petcat/my.config/master/shadowsocks/shadowsocks-rust/shadowsocks-rust.service
```
