# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

ulimit -c 0
umask 022
set history=200
set savehistory=200
set -o ignoreeof
unset autologout

export SHELL=/bin/bash
#export HOME=/home/sohda
export TMPDIR=/tmp
export TZ=JST-09
export MAKE_MODE=unix

PATH=/usr/local/sbin:/usr/sbin:/sbin:.:~/bin
PATH=/usr/local/bin:/usr/X11R6/bin:/usr/bin:/bin:$PATH
PAGER=less
JLESSCHARSET=japanese-sjis
export PATH PAGER JLESSCHARSET

PS1="$HOSTNAME:\w$ "

if [ -n ${DISPLAY} ]; then
    export DISPLAY=localhost:0.0
fi

if [ ! -n "${TERM}" ]; then
    TERM=cygwin
fi

alias ls="ls -F --color=auto --show-control-char"
alias la="ls -aF"
alias ll="ls -l"
alias j=jobs
alias vi=vim
alias more=less

SYSTEM=`cygpath -u ${SYSTEMROOT}`/system32
alias ping="$SYSTEM/ping.exe"
alias arp="$SYSTEM/arp.exe"
alias nslookup="$SYSTEM/nslookup.exe"
alias traceroute="$SYSTEM/tracert.exe"
alias route="$SYSTEM/route.exe"
alias netstat="$SYSTEM/netstat.exe"
alias ipconfig="$SYSTEM/ipconfig.exe"
alias ifconfig=ipconfig
#alias start="$SYSTEM/CMD.exe /c start"
alias start=cygstart
unset SYSTEM                           

