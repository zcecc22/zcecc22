# ~/.bashrc

# bypass
# ------

[ -z "$PS1" ] && return

# gpg agent
# ---------

if [ -z "$DISPLAY" ]; then
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

PS1="\n${GREEN}@\h${RED}[\w]${YELLOW}${LIGHTRED}${NIL}$ "

complete -cf sudo
[ -e /etc/bash_completion ] && source /etc/bash_completion

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
alias df="df -h"
alias diff='diff -u'
alias ls='ls -hF --color=auto'
alias mkdir='mkdir -pv'
alias mv="mv -v"
alias rm="rm -Irv"

alias screen="if ! screen -d -r &> /dev/null; then screen; fi"
alias aria2c="aria2c --enable-dht6=true --dscp=8"
alias vpn="sudo openvpn ~/.vpn/IPredator-CLI-Password-https.conf"
alias mount_array0='sudo cryptsetup luksOpen /dev/md/array0 array0; sudo mount /array0'

alias autoremove='sudo apt-get --purge autoremove'
alias clean='sudo apt-get clean'
alias install='sudo apt-get install'
alias mark='sudo apt-mark auto'
alias remove='sudo apt-get --purge remove'
alias search='apt-cache search'
alias update='sudo apt-get update'
alias upgrade='sudo apt-get dist-upgrade'

alias halt='sudo shutdown -h now'
alias reboot='sudo reboot'

# functions
# ---------

# SYSTEMD COMMANDS
  if which systemctl &> /dev/null; then
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
  if which ffmpeg &> /dev/null; then
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
    __mp4c_force() {
      OUTPUT_DIR="$1"
      INPUT_FILE="$2"

      filename=$(basename "$INPUT_FILE")
      extension="${filename##*.}"

      vcodec=libx264
      acodec=aac

      echo "[Converting] ${filename} (${vcodec}/${acodec})"
      ffmpeg -threads 2 -i "$INPUT_FILE" -strict experimental -map_metadata -1 \
        -c:v ${vcodec} -preset medium -crf 23 \
        -c:a ${acodec} -b:a 192k \
        -f mp4 "${OUTPUT_DIR}/${filename/%.${extension}/.mp4}" &
      wait $!
    }
    convert_mp4() {
      export -f __mp4c
      find $1 -type f \( -iname \*.mp4 -o -iname \*.avi -o -iname \*.mkv \) \
        -exec bash -c "__mp4c \"$2\" \"{}\"" \;
    }
    convert_mp4_force() {
      export -f __mp4c_force
      find $1 -type f \( -iname \*.mp4 -o -iname \*.avi -o -iname \*.mkv \) \
        -exec bash -c "__mp4c_force \"$2\" \"{}\"" \;
    }
  fi

# BACKUP COMMANDS
  if which rsync &> /dev/null; then
    backup_root() {
      sudo rsync -aHAX --numeric-ids --delete --info=progress2 \
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
    }
    backup_node99() {
      sudo rsync -axH --delete --info=progress2 \
        --exclude "temporary" \
        --exclude "chroot/array*/*" \
        node99:/array0/* /array0
    }
  fi
