# Jekyll 

## 模板
https://jekyllthemes.io/free   
https://jekyllthemes.dev/   
http://jekyllthemes.org/  

## 安装：  

### Debian 10 & ubuntu 18.04 以上
https://computingforgeeks.com/how-to-install-jekyll-on-ubuntu-18-04/    

```
apt -y install make build-essential    
apt -y install ruby ruby-dev    
```
`source ~/.bashrc`   
```
gem install bundler   
gem install jekyll    
```

### Debian 9 以下

```
apt-add-repository -y ppa:rael-gc/rvm
apt update
apt install rvm
# 开新窗口
rvm install ruby
gem install bundler jekyll
```


### 官方文档已失效，Ruby 版本需2.4以上 

```
echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

apt install ruby-full build-essential zlib1g-dev
gem install bundler jekyll
```
##### 提示版本过低，低于2.4，https://github.com/rvm/ubuntu_rvm

> ERROR:  Error installing jekyll:   
>	jekyll-sass-converter requires Ruby version >= 2.4.0.    
> 1 gem installed    


## 使用

升级：`bundle update` 或 `gem update jekyll`    

下载主题，然后生成 `jekyll build` (jekyll b)  


