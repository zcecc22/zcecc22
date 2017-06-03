# ~/.bashrc

# bypass
# ------

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

PS1="\n${GREEN}@\h${RED}[\w]${YELLOW}${LIGHTRED}${NIL}$ "

complete -cf sudo
[ -e /etc/bash_completion ] && source /etc/bash_completion

stty -ixon
stty -ixoff

shopt -s cdspell
shopt -s checkwinsize
shopt -s histappend
shopt -s cmdhist
shopt -s extglob
shopt -s no_empty_cmd_completion

export EDITOR=nano

# paths
# -----

export GOPATH="${HOME}/.go"
export NODEPATH="${HOME}/.node/bin"
export NODEPKG="${HOME}/.node/pkg"
export PATH="${HOME}/.bin:${GOPATH}/bin:${NODEPATH}/bin:${NODEPKG}/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

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
alias mv="mv -v"
alias rm="rm -rIv"

alias ls='ls -hF --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ..='cd ..'
alias df='df -h'
alias diff='diff -u'
alias du='du -ch'
alias free='free -m'
alias grep='grep --color=auto'
alias mkdir='mkdir -pv'
alias more='less'
alias nano='nano -w'
alias tmux='tmux attach'

alias search='apt-cache search'
alias update='sudo apt-get update'
alias upgrade='sudo apt-get dist-upgrade'
alias install='sudo apt-get install'
alias remove='sudo apt-get --purge remove'
alias autoremove='sudo apt-get --purge autoremove'
alias clean='sudo apt-get clean'

alias reboot='sudo reboot'
alias halt='sudo shutdown -h now'

alias ftp_temporary='ncftpput -z -R node99 /temporary/'

# functions
# ---------

# SYSTEMD COMMANDS
  if which systemctl &>/dev/null; then
    start() {
      sudo systemctl start $1.service
    }
    restart() {
      sudo systemctl restart $1.service
    }
    stop() {
      sudo systemctl stop $1.service
    }
    enable() {
      sudo systemctl enable $1.service
    }
    status() {
      sudo systemctl status $1.service
    }
    disable() {
      sudo systemctl disable $1.service
    }
  fi

# MP4C COMMANDS
  if which ffmpeg &>/dev/null; then
    __mp4c() {
      OUTPUT_DIR="$1"
      INPUT_FILE="$2"

      filename=$(basename "$INPUT_FILE")
      extension="${filename##*.}"

      if ffprobe "$INPUT_FILE" 2>&1 | grep "Video: h264" > /dev/null
      then
        vcodec=copy
      else
        vcodec=libx264
      fi

      if ffprobe "$INPUT_FILE" 2>&1 | grep "Audio: aac" > /dev/null
      then
        acodec=copy
      else
        acodec=aac
      fi

      echo "[Converting] ${filename} (${vcodec}/${acodec})"
      ffmpeg -threads 2 -i "$INPUT_FILE" -strict experimental -map_metadata -1 \
        -c:v ${vcodec} -preset medium -crf 23 \
        -c:a ${acodec} -b:a 192k \
        -f mp4 "${OUTPUT_DIR}/${filename/%.${extension}/.mp4}" &
      wait $!
    }
    convert_mp4() {
      export -f __mp4c
      find ./ -name "$1" -exec bash -c "__mp4c \"$2\" \"{}\"" \;
    }
  fi

# BACKUP COMMANDS
  if which rsync &>/dev/null; then
    backup_root() {
      sudo rsync -aHAXv --numeric-ids --delete --progress \
      --exclude "/array*/*" \
      --exclude "/backup/*" \
      --exclude "/dev/*" \
      --exclude "/export/*" \
      --exclude "/media/*" \
      --exclude "/mnt/*" \
      --exclude "/proc/*" \
      --exclude "/run/*" \
      --exclude "/swapfile" \
      --exclude "/sys/*" \
      --exclude "/tmp/*" \
      --exclude "/var/run/*" \
      --exclude "/var/tmp/*" \
      / nodex:/array0/backup/"$HOSTNAME"/

      sudo rsync -aHAXv --numeric-ids --delete --progress \
      --exclude "/array*/*" \
      --exclude "/backup/*" \
      --exclude "/dev/*" \
      --exclude "/export/*" \
      --exclude "/home/*" \
      --exclude "/media/*" \
      --exclude "/mnt/*" \
      --exclude "/proc/*" \
      --exclude "/run/*" \
      --exclude "/swapfile" \
      --exclude "/sys/*" \
      --exclude "/tmp/*" \
      --exclude "/var/run/*" \
      --exclude "/var/tmp/*" \
      / /backup/
    }
    backup_array0_full() {
      sudo rsync -aHAXv --numeric-ids --delete --progress \
      --exclude "backup" \
      /array0/* node99:/array0/
    }
    backup_array0_partial() {
      sudo rsync -aHAXv --numeric-ids --delete --progress \
      --exclude "backup" \
      --exclude "temporary" \
      /array0/* node99:/array0/
    }
  fi
