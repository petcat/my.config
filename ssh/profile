# ==================================
# 通用Alias: .profile + .my_aliases 
# ==================================

# 基本环境变量
export PATH="$HOME/bin:$PATH"
export HISTSIZE=5000

# 核心 alias (通用)
alias ls='ls --color=auto'
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias iprofile='source ~/.profile'
alias ialiases='nano ~/.my_aliases'
alias reprofile='. ~/.profile'


# 提示符：绿色用户@主机 + 蓝色路径
PS1="\033[32m\u@\h:\033[34m\w\033[0m#"
# PS1="\033[31m\u@\h:\w\033[0m\#"

# 如果存在扩展 alias 文件，就加载它
[ -f ~/.my_aliases ] && . ~/.my_aliases
