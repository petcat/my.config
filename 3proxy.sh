#!/bin/bash
 
############################################################
# Install 3proxy (version 0.6.1, perfect proxy for LEB, supports authentication, easy config)
############################################################
function install_3proxy {
 
    if [ -z "$1" ]
    then
        die "Usage: `basename $0` 3proxy [http-proxy port #]"
    fi
        echo "You have chosen port $http_porty"
    # Build 3proxy
    echo "Downloading and building 3proxy"
    mkdir /tmp/proxy
    cd /tmp/proxy
    wget https://github.com/z3APA3A/3proxy/releases/download/0.8.13/3proxy-0.8.13.zip
    unzip 3proxy-0.8.13.zip
    rm -rf 3proxy-0.8.13.zip
    cd 3proxy-0.8.13
    apt-get install build-essential
    make -f Makefile.Linux
     
    # Navigate to 3proxy Install Directory
    cd src
    mkdir /etc/3proxy/
     
    # Move 3proxy program to a non-temporary location and navigate there
    mv 3proxy /etc/3proxy/
    cd /etc/3proxy/
     
    # Create a Log File
    touch /var/log/3proxy.log
     
    # Create basic config that sets up HTTP proxy with user authentication
    touch /etc/3proxy/3proxy.cfg
     
    cat > "/etc/3proxy/3proxy.cfg" <<END
# Specify valid name servers. You can locate them on your VPS in /etc/resolv.conf
#
nserver 8.8.8.8
nserver 8.8.4.4
# Leave default cache size for DNS requests:
#
nscache 65536
# Leave default timeout as well:
#
timeouts 1 5 30 60 180 1800 15 60
# If your server has several IP-addresses, you need to provide an external one
# Alternatively, you may ignore this line
#external YOURSEVERIP
# Provide the IP-address to be listened
# If you ignore this line, proxy will listen all the server.s IP-addresses
#internal YOURSEVERIP
# Create users proxyuser1 and proxyuser2 and specify a password
#
users \$/etc/3proxy/.proxyauth
# Specify daemon as a start mode
#
daemon
# and the path to logs, and log format. Creation date will be added to a log name
log /var/log/3proxy.log
logformat "- +_L%t.%. %N.%p %E %U %C:%c %R:%r %O %I %h %T"
# Compress the logs using gzip
#
archiver gz /usr/bin/gzip %F
# store the logs for 30 days
rotate 30
# Configuring http(s) proxy
#
# enable strong authorization. To disable authentication, simply change to 'auth none'
# added authentication caching to make life easier
authcache user 60
auth strong cache
# and restrict access for ports via http(s)-proxy and deny access to local interfaces
#
deny * * 127.0.0.1,192.168.1.1
allow * * * 80-88,8080-8088 HTTP
allow * * * 443,8443 HTTPS
# run http-proxy ... without ntlm-authorization, complete anonymity and port ...
#
proxy -n -p$1 -a
# Configuring socks5-proxy
#
# enable strong authorization and authentication caching
#
# Purge the access-list of http-proxy and allow certain users
#
# set the maximum number of simultaneous connections to 32
#authcache user 60
#auth strong cache
#flush
#allow userdefined
#socks
END
     
    # Give appropriate permissions for config file
    chmod 600 /etc/3proxy/3proxy.cfg
     
    # Create external user authentication file
    touch /etc/3proxy/.proxyauth
    chmod 600 /etc/3proxy/.proxyauth 
    cat > "/etc/3proxy/.proxyauth" <<END
## addusers in this format:
## user:CL:password
## see for documenation:  http://www.3proxy.ru/howtoe.asp#USERS
END
     
    # Create initialization scripty so 3proxy starts with system
    touch /etc/init.d/3proxy
    chmod  +x /etc/init.d/3proxy
    cat > "/etc/init.d/3proxy" <<END
#!/bin/sh
#
# chkconfig: 2345 20 80
# description: 3proxy tiny proxy server
#
#
#
#
 
case "\$1" in
   start)
       echo Starting 3Proxy
 
       /etc/3proxy/3proxy /etc/3proxy/3proxy.cfg
       ;;
 
   stop)
       echo Stopping 3Proxy
       /usr/bin/killall 3proxy
       ;;
 
   restart|reload)
       echo Reloading 3Proxy
       /usr/bin/killall -s USR1 3proxy
       ;;
   *)
       echo Usage: \$0 "{start|stop|restart}"
       exit 1
esac
exit 0
 
END
 
    # Make sure 3proxy starts with system
 
    update-rc.d 3proxy defaults 
 
    # Add Iptable entry for specified port
    echo "Adding necessary Iptable entry"
    iptables -I INPUT -p tcp --dport $1 -j ACCEPT
    if [ -f /etc/iptables.up.rules ];
    then
    iptables-save < /etc/iptables.up.rules
    fi
    echo ''
    echo '3proxy successfully installed, before you can use it you must add a user and password, for proxy authentication. '
    echo 'This can be done using the "3proxyauth [user] [password]" it will add the user to the 3proxy auth file. '
    echo 'If you do not want authentication, edit the 3proxy config file /etc/3proxy/3proxy.cfg  and set authentication to none (auth none)'
    echo 'This will leave your http proxy open to anyone and everyone.'
     
    /etc/init.d/3proxy start
     
    echo "3proxy started"
}
 
function 3proxyauth {
 
    if [[ -z "$1" || -z "$2" ]]
    then
        die "Usage: `basename $0` 3proxyauth username password"
    fi
     
    if [ -f /etc/3proxy/.proxyauth ];
    then
    echo "$1:CL:$2" >> "/etc/3proxy/.proxyauth"
    echo "User: $1 successfully added"
    else
    echo "Please install 3proxy (through this script) first."
    fi
 
}
######################################################################## 
# START OF PROGRAM
########################################################################
export PATH=/bin:/usr/bin:/sbin:/usr/sbin
 
check_sanity
case "$1" in
mysql)
    install_mysql
    ;;
exim4)
    install_exim4
    ;;
nginx)
    install_nginx
    ;;
php)
    install_php
    ;;
dotdeb)
    install_dotdeb
    ;;
site)
    install_site $2
    ;;
wordpress)
    install_wordpress $2
    ;;
mysqluser)
    install_mysqluser $2
    ;;
iptables)
    install_iptables $2
    ;;
dropbear)
    install_dropbear $2
    ;;
3proxy)
    install_3proxy $2
    ;;
3proxyauth)
    3proxyauth $2 $3
    ;;  
ps_mem)
    install_ps_mem
    ;;
apt)
    update_apt_sources
    ;;
vzfree)
    install_vzfree
    ;;
webmin)
    install_webmin
    ;;
sshkey)
    gen_ssh_key $2
    ;;
motd)
    configure_motd
    ;;
locale)
    fix_locale
    ;;
test)
    runtests
    ;;
info)
    show_os_arch_version
    ;;
system)
    update_timezone
    remove_unneeded
    update_upgrade
    install_dash
    install_vim
    install_nano
    install_htop
    install_mc
    install_iotop
    install_iftop
    install_syslogd
    apt_clean
    ;;
*)
    show_os_arch_version
    echo '  '
    echo 'Usage:' `basename $0` '[option] [argument]'
    echo 'Available options (in recomended order):'
    echo '  - dotdeb                 (install dotdeb apt source for nginx 1.2+)'
    echo '  - system                 (remove unneeded, upgrade system, install software)'
    echo '  - dropbear  [port]       (SSH server)'
    echo '  - iptables  [port]       (setup basic firewall with HTTP(S) open)'
    echo '  - mysql                  (install MySQL and set root password)'
    echo '  - nginx                  (install nginx and create sample PHP vhosts)'
    echo '  - php                    (install PHP5-FPM with APC, cURL, suhosin, etc...)'
    echo '  - exim4                  (install exim4 mail server)'
    echo '  - site      [domain.tld] (create nginx vhost and /var/www/$site/public)'
    echo '  - mysqluser [domain.tld] (create matching mysql user and database)'
    echo '  - wordpress [domain.tld] (create nginx vhost and /var/www/$wordpress/public)'
    echo '  '
    echo '... and now some extras'
    echo '  - info                   (Displays information about the OS, ARCH and VERSION)'
    echo '  - sshkey                 (Generate SSH key)'
    echo '  - apt                    (update sources.list for UBUNTU only)'
    echo '  - ps_mem                 (Download the handy python script to report memory usage)'
    echo '  - vzfree                 (Install vzfree for correct memory reporting on OpenVZ VPS)'
    echo '  - motd                   (Configures and enables the default MOTD)'
    echo '  - locale                 (Fix locales issue with OpenVZ Ubuntu templates)'
    echo '  - webmin                 (Install Webmin for VPS management)'
    echo '  - test                   (Run the classic disk IO and classic cachefly network test)'
    echo '  - 3proxy                 (Install 3proxy - Free tiny proxy server, with authentication support, HTTP, SOCKS5 and whatever you can throw at it)'
    echo '  - 3proxyauth             (add users/passwords to your proxy user authentication list)'
    echo '  '
    ;;
esac
