## Hugo
https://themes.gohugo.io/   
https://github.com/gohugoio/hugo/releases   
https://github.com/gohugoio/hugo/releases/download/v0.57.1/hugo_0.57.1_Linux-64bit.deb  

新建：`hugo new site .`  生成`hugo`

## Jekyll
https://jekyllthemes.io/free   
https://jekyllthemes.dev/   
http://jekyllthemes.org/  

```
echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

apt install ruby-full build-essential zlib1g-dev
gem install bundler jekyll
```
下载主题，然后生成 `jekyll build` (jekyll b)

## Hexo
https://hexo.io/themes/ 
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | sh
source ~/.bashrc
nvm install stable
npm install hexo-cli -g
```
新建：`hexo init .`  生成：`hexo generate` (hexo g)      
