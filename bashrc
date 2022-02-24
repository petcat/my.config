# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
export PATH=$PATH:~/.cargo/bin

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# system & tools command aliases
alias ll='ls -halF'
alias la='ls -A'
alias l='ls -CF'
alias bbr='lsmod | grep bbr'
alias ping='ping -c 9'
alias aliass='source ~/.bashrc'
alias pk='pkill -9'
alias systart='systemctl start'
alias systop='systemctl stop'
alias systatus='systemctl status'
alias update='apt update'
alias upgrade='apt update && apt upgrade'
alias remove='apt remove'
alias removes='apt purge'
alias autoremove='apt autoremove'
alias install='apt install'
alias ver='lsb_release -a'
alias sysver='lsb_release -a'
alias nano='nano -w -m'
alias scr='screen -R one'
alias tmux0='tmux a -t 0'
alias tmux1='tmux a -t 1'
alias targz='tar -czvf'
alias tarz='tar -czvf'
alias untar='tar -zxvf'
alias gits='git clone'
alias sou='find / -name'
alias finds='find / -name'
alias deb='dpkg -i'
alias get='setsid'
alias nohup='nohup >/dev/null 2>&1'
alias no='setsid'
alias wget0='wget --no-check-certificate'
alias vpsinfo='run-parts /etc/update-motd.d/'
alias ressh='/etc/init.d/ssh restart'
## Web Server
# Nginx
alias renginx='systemctl restart nginx'
alias inginx='systemctl status nginx'
# php
alias rephp56='systemctl restart php5.6-fpm'
alias rephp70='systemctl restart php7.0-fpm'
alias rephp71='systemctl restart php7.1-fpm'
alias rephp72='systemctl restart php7.2-fpm'
alias rephp73='systemctl restart php7.3-fpm'
alias rephp74='systemctl restart php7.4-fpm'
# caddy 2.x
alias icaddy='systemctl status caddy'
alias recaddy='systemctl reload caddy'
alias stopcaddy='systemctl stop caddy'
alias caddyoff='systemctl stop caddy'
alias startcaddy='systemctl start caddy'
alias caddyon='systemctl start caddy'
alias caddyfiles='mcedit /etc/caddy/Caddyfile'
alias caddyfile='nano -w -m /etc/caddy/Caddyfile'
# caddy 1.x
alias caddy-re='caddy -service restart'
alias caddy-stop='caddy -service stop'
alias caddy-start='caddy -service start'
alias caddy-status='caddy -service status'
alias mycaddy='caddy -service status'
alias caddy-files='nano -w -m /usr/local/bin/Caddyfile'
# other
alias mkdocz='mkdocs build'
alias ihugo='hugo new site'
alias rev2ray='service v2ray restart'
alias iv2ray='service v2ray status'
alias rev2='service v2ray restart'
alias iv2='service v2ray status'
alias v2stop='service v2ray stop'
alias v2start='service v2ray start'
alias itrojan='systemctl status trojan'
alias retrojan='systemctl restart trojan'
alias trojan-start='systemctl start trojan'
alias trojan-stop='systemctl stop trojan'
alias refb='systemctl restart filebrowser'
alias fb-start='systemctl start filebrowser'
alias fb-stop='systemctl stop filebrowser'
alias ifb='systemctl status filebrowser'
alias fb-status='systemctl status filebrowser.service'
alias ssstart='systemctl start shadowsocks-libev'
alias ssstop='systemctl stop shadowsocks-libev'
alias ress='systemctl restart shadowsocks-libev'
alias iss='systemctl status shadowsocks-libev'
alias upss='snap refresh shadowsocks-libev --edge'
# Transfer
alias zhuan='curl --upload-file'
# Dwnload
alias aira2c='aria2c'
alias p2p='aria2c'
alias aria2c-start='systemctl start aria2c'
alias aria2c-stop='systemctl stop aria2c'
alias iaria2c='systemctl status aria2c'
alias myaria2c='systemctl status aria2c'
alias rearia2c='systemctl restart aria2c'
alias ydl='youtube-dl -F'
alias dl='youtube-dl -f'
alias dl1080='youtube-dl -f 137+140'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi
PS1='${debian_chroot:+($debian_chroot)}\[\e[1;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
export PROMPT_COMMAND='{ msg=$(history 1 | { read x y; echo $y; });user=$(whoami); echo $(date "+%Y-%m-%d %H:%M:%S"):$user:`pwd`/:$msg ---- $(who am i); } >> /tmp/`hostname`.`whoami`.history-timestamp'
