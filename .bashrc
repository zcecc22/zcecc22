# ~/.bashrc

# bypass
# ---------

[ -z "$PS1" ] && return

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

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

PS1="\n${GREEN}@\h${RED}[\w]${YELLOW}${debian_chroot:+($debian_chroot)}${LIGHTRED}${NIL}$ "

complete -cf sudo
[ -e /etc/bash_completion ] && source /etc/bash_completion

stty -ixon
stty -ixoff

shopt -s cmdhist
shopt -s histappend

# exports
# -------

export GOPATH="${HOME}/.go"
export NODEPATH="${HOME}/.node/bin"
export NODEPKG="${HOME}/.node/pkg"
export PATH="${HOME}/.bin:${GOPATH}/bin:${NODEPATH}/bin:${NODEPKG}/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
export LC_ALL=en_US.utf8
export LANG=en_US.utf8
export HISTCONTROL=eraseboth
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls:ll:la:clear:exit'
export HISTSIZE=100
export HISTFILESIZE=${HISTSIZE}
export HISTTIMEFORMAT="[%Y-%m-%d - %H:%M:%S] "
export GREP_OPTIONS='--color=auto'
export EDITOR=emacs

export GROFF_NO_SGR=1
export LESS_TERMCAP_mb=$'\E[0;31m'
export LESS_TERMCAP_md=$'\E[1;34m'
export LESS_TERMCAP_us=$'\E[1;32m'
export LESS_TERMCAP_so=$'\E[41;1;37m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_me=$'\E[0m'

# aliases
# -------

alias ls="ls -hHF --group-directories-first --color=auto"
alias cp="cp -rv"
alias mv="mv -v"
alias rm="rm -rIv"
alias ..="cd .."
alias ...="cd ../.."
alias df="df -H"

alias search="apt-cache search"
alias update="sudo apt-get update"
alias upgrade="sudo apt-get dist-upgrade"
alias install="sudo apt-get install"
alias remove="sudo apt-get --purge remove"
alias autoremove="sudo apt-get --purge autoremove"
alias clean="sudo apt-get clean"

alias tmux="tmux attach"
alias diff="diff -u"
