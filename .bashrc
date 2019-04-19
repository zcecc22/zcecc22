# ~/.bashrc

# bypass
# ------

[ -z "${PS1}" ] && return

# gpg agent
# ---------

if which gpg &> /dev/null; then
  export GPG_TTY=$(tty)
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  gpg-connect-agent updatestartuptty /bye &> /dev/null
fi

# main conf
# ---------

RED='\[\033[0;31m\]'
LIGHTRED='\[\033[1;31m\]'
GREEN='\[\033[0;32m\]'
LIGHTGREEN='\[\033[1;32m\]'
YELLOW='\[\033[0;33m\]'
LIGHTYELLOW='\[\033[1;33m\]'
BLUE='\[\033[0;34m\]'
LIGHTBLUE='\[\033[1;34m\]'
PURPLE='\[\033[0;35m\]'
LIGHTPURPLE='\[\033[1;35m\]'
CYAN='\[\033[0;36m\]'
LIGHTCYAN='\[\033[1;36m\]'
WHITE='\[\033[1;37m\]'
LIGHTGREY='\[\033[0;37m\]'
BLACK='\[\033[1;30m\]'
DARKGREY='\[\033[0;30m\]'
NIL='\[\033[00m\]'

PS1="\n${GREEN}@\h${RED}[\w]${NIL}$ "

complete -cf sudo
[ -e /etc/bash_completion ] && source /etc/bash_completion

shopt -s cdspell
shopt -s checkwinsize
shopt -s histappend
shopt -s cmdhist
shopt -s extglob
shopt -s no_empty_cmd_completion

export EDITOR=nano

# wsl fix
# -------

if grep -q Microsoft /proc/version; then
  if [ "$(umask)" == '0000' ]; then
    umask 0022
  fi
fi

# paths
# -----

export PATH="${HOME}/.bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

# locale
# ------

export LC_ALL=en_US.utf8
export LANG=en_US.utf8

# history
# -------

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
export HISTIGNORE='&:ls:ll:la:cd:exit:clear:history'

# aliases
# -------

alias cp="cp -rv"
alias df="df -h"
alias diff='diff -u'
alias ls='ls -hF --color=auto'
alias mkdir='mkdir -pv'
alias mv="mv -v"
alias rm="rm -rfv"

alias screen="screen -T ${TERM} -a -D -R"

alias autoremove='sudo apt --purge autoremove'
alias clean='sudo apt clean'
alias install='sudo apt install'
alias remove='sudo apt --purge remove'
alias search='sudo apt search'
alias update='sudo apt update'
alias upgrade='sudo apt dist-upgrade'

alias halt='sudo shutdown -h now'
alias reboot='sudo reboot'

alias aria2c="aria2c -Z --enable-dht6=true --dscp=8"
alias vpn="sudo openvpn ~/.vpn/IPredator-CLI-Password-default.conf"

# scripts
# -------

[ -e ~/.scripts ] && for s in ~/.scripts/*; do source $s; done
