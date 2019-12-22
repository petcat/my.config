## Hugo
https://themes.gohugo.io/   
https://github.com/gohugoio/hugo/releases   
https://github.com/gohugoio/hugo/releases/download/v0.61.0/hugo_0.61.0_Linux-64bit.deb   

新建：`hugo new site .`  生成`hugo`

## Jekyll
https://jekyllthemes.io/free   
https://jekyllthemes.dev/   
http://jekyllthemes.org/  

安装：  
```
echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

apt install ruby-full build-essential zlib1g-dev
gem install bundler jekyll
```
提示版本过低，低于2.4，https://github.com/rvm/ubuntu_rvm

> ERROR:  Error installing jekyll:   
>	jekyll-sass-converter requires Ruby version >= 2.4.0.    
> 1 gem installed    


```
apt-add-repository -y ppa:rael-gc/rvm
apt update
apt install rvm
# 开新窗口
rvm install ruby
gem install bundler jekyll
```

升级：`bundle update` 或 `gem update jekyll`    
下载主题，然后生成 `jekyll build` (jekyll b)   

## Hexo
https://hexo.io/themes/  
https://github.com/nvm-sh/nvm/releases  
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | sh
source ~/.bashrc
nvm install stable
npm install hexo-cli -g
```
新建：`hexo init .`  生成：`hexo generate` (hexo g)      
