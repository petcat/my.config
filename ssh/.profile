# ==================================
# 通用Alias: .profile + .my_aliases 
# ==================================
# 基本环境变量
export PATH="$HOME/bin:$PATH"
export HISTSIZE=5000
# 核心 alias (通用)
alias ls='ls -A --color=auto'
alias ll='ls -ahlF --color=auto'
alias lll='ls -lahFR --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias reprofile='. ~/.profile'
alias iprofile='source ~/.profile'
alias ialiases='nano ~/.my_aliases'

# 提示符：绿色用户@主机 + 蓝色路径
# PS1="\033[32m\u@\h:\033[34m\w\033[0m#"
PS1="\033[33m[\t]\033[32m\u@\h:\033[34m\w\033[0m#"
# PS1="\033[31m[\t]\033[33m\u@\h:\033[32m\w\033[0m#"

# 如果存在扩展 alias 文件，就加载它
[ -f ~/.my_aliases ] && . ~/.my_aliases
