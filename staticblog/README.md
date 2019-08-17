## Hugo
https://themes.gohugo.io/   
https://github.com/gohugoio/hugo/releases   
https://github.com/gohugoio/hugo/releases/download/v0.57.1/hugo_0.57.1_Linux-64bit.deb  

网站：`hugo new site .`  生成`hugo`

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
生成 `jekyll build`

## Hexo
https://hexo.io/themes/ 
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | sh
nvm install stable
npm install hexo-cli -g
```
网站：`hexo init .`
