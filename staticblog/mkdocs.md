# mkdocs 安装 

## python2.7 （弃用）
```
python --version   
apt install python-pip  
pip install mkdocs  
```
----

## python3.x
```
#查看版本
python3 -V 
#如没有则安装
apt install python3
# 安装 pip
apt install python3-venv python3-pip  
pip3 install mkdocs   
```

升级
`pip3 install -U pip`  
`pip3 install -U mkdocs`  

主题  
多种配色主题， demo: https://mkdocs.github.io/mkdocs-bootswatch/
```
pip3 install mkdocs-bootswatch
# theme: amelia  cerulean  cosmo  cyborg  flatly  journal  readable  simplex  slate  spacelab  united  yeti 
```
https://github.com/mkdocs/mkdocs/wiki/MkDocs-Themes    

theme: ivory   
pip3 install mkdocs-ivory    
demo: https://pheasant.daizutabi.net/    

theme: alabaster   
pip3 install mkdocs-alabaster   
demo: https://mkdocs-alabaster.ale.sh/   
