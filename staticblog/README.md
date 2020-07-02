## Hugo
https://themes.gohugo.io/   
https://github.com/gohugoio/hugo/releases   
https://github.com/gohugoio/hugo/releases/download/v0.61.0/hugo_0.61.0_Linux-64bit.deb   

新建：`hugo new site .`  生成`hugo`

## Jekyll

详细： https://github.com/petcat/my.config/blob/master/staticblog/jekyll.md

https://jekyllthemes.io/free   
https://jekyllthemes.dev/   
http://jekyllthemes.org/  

安装：  

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


### 升级：
`bundle update` 或 `gem update jekyll`  

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
