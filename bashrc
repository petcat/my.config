# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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

# some more ls aliases
alias ll='ls -halF'
alias la='ls -A'
alias l='ls -CF'

alias aliass='source /etc/profile'
alias nginxdir='cd /etc/nginx/conf.d'
alias update='apt-get update'
alias upgrade='apt-get update && apt-get upgrade'
alias remove='apt-get remove'
alias removes='apt-get remove --purge'
alias autoremove='apt-get autoremove'
alias install='apt-get install'
alias ver='lsb_release -a'
alias nano='nano -w'
alias scr='screen -R one'
alias targz='tar -czvf'
alias tarz='tar -czvf'
alias untar='tar -zxvf'
alias gits='git clone'
alias sou='find / -name'
alias finds='find / -name'
alias deb='dpkg -i'
#
alias renginx='/etc/init.d/nginx reload'
alias ressh='service ssh restart'
alias rephp5='systemctl restart php5.6-fpm'
alias rephp='systemctl restart php7.1-fpm'
alias recaddy='caddy -service restart'
alias caddy-stop='caddy -service stop'
alias caddy-start='caddy -service start'
alias caddy-status='caddy -service status'
alias mycaddy='caddy -service status'
alias icaddy='caddy -service status'
alias caddyfiles='nano /usr/local/bin/Caddyfile'
alias ressp='/etc/init.d/shadowsocks-python restart'
alias ressg='/etc/init.d/shadowsocks-go restart'
alias ressl='/etc/init.d/shadowsocks-libev restart'
# Dwnload
alias p2pbak='aria2c --enable-rpc --rpc-listen-all=true --rpc-allow-origin-all --rpc-secret=112121 -D'
alias aira2c='aria2c'
alias p2p='aria2c'
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
