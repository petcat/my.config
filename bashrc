# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

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
alias aliass='source ~/.bashrc'
alias pk='pkill -9'
alias update='apt update'
alias upgrade='apt update && apt upgrade'
alias remove='apt remove'
alias removes='apt purge'
alias autoremove='apt autoremove'
alias install='apt install'
alias ver='lsb_release -a'
alias nano='nano -w -m'
alias scr='screen -R one'
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
# Web Server
alias nginxdir='cd /etc/nginx/conf.d'
alias renginx='/etc/init.d/nginx reload'
alias inginx='/etc/init.d/nginx status'
alias ressh='service ssh restart'
alias rephp5='systemctl restart php5.6-fpm'
alias rephp='systemctl restart php7.2-fpm'
alias recaddy='caddy -service restart'
alias caddy-stop='caddy -service stop'
alias caddy-start='caddy -service start'
alias caddy-status='caddy -service status'
alias mycaddy='caddy -service status'
alias icaddy='caddy -service status'
alias caddyfiles='nano -w -m /usr/local/bin/Caddyfile'
alias mkdocz='mkdocs build'
alias rev2ray='service v2ray restart'
alias myv2ray='service v2ray status'
alias rev2='service v2ray restart'
alias iv2='service v2ray status'
alias v2stop='service v2ray stop'
alias v2start='service v2ray start'
alias refb='systemctl restart filebrowser.service'
alias fb-start='systemctl start filebrowser.service'
alias fb-stop='systemctl stop filebrowser.service'
alias ifb='systemctl status filebrowser.service'
alias fb-status='systemctl status filebrowser.service'
alias ressp='/etc/init.d/shadowsocks-python restart'
alias ressg='/etc/init.d/shadowsocks-go restart'
alias ressl='/etc/init.d/shadowsocks-libev restart'
# Transfer
alias zhuan='curl --upload-file'
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
# Add Transfer
transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi
PS1='${debian_chroot:+($debian_chroot)}\[\e[1;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
export PROMPT_COMMAND='{ msg=$(history 1 | { read x y; echo $y; });user=$(whoami); echo $(date "+%Y-%m-%d %H:%M:%S"):$user:`pwd`/:$msg ---- $(who am i); } >> /tmp/`hostname`.`whoami`.history-timestamp'
