# ~/.bashrc

# bypass
# ------

[ -z "${PS1}" ] && return

# chroot
# ------

[ -e /chroot ] && chroot=true

# gpg agent
# ---------

if [ -z "${DISPLAY}" ] && which gpg &> /dev/null; then
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

PS1="\n${GREEN}@\h${YELLOW}${chroot:+(chroot)}${RED}[\w]${NIL}$ "

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
alias rm="rm -rfv"

alias aria2c="aria2c --enable-dht6=true --dscp=8"
alias screen="screen -T ${TERM} -a -D -R"

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

# mp4c commands
  if which ffmpeg &> /dev/null; then
    __mp4c() {
      OUTPUT_DIR="$1"
      INPUT_FILE="$2"

      filename=$(basename "${INPUT_FILE}")
      extension="${filename##*.}"

      if ffprobe "${INPUT_FILE}" 2>&1 | grep -q "Video: h264" || ffprobe "${INPUT_FILE}" 2>&1 | grep -q "Video: hevc"
      then
        vcodec=copy
      else
        vcodec=libx265
      fi

      if ffprobe "${INPUT_FILE}" 2>&1 | grep -q "Audio: aac"
      then
        acodec=copy
      else
        acodec=aac
      fi

      echo "[Converting] ${filename} (${vcodec}/${acodec})"
      ffmpeg -threads 2 -i "${INPUT_FILE}" \
        -strict experimental -map_metadata -1 \
        -c:v ${vcodec} -preset medium -crf 28 \
        -c:a ${acodec} -b:a 192k \
        -f mp4 "${OUTPUT_DIR}/${filename/%.${extension}/.mp4}" &
      wait $!
    }
    convert_mp4() {
      export -f __mp4c
      find $1 -type f \( -iname \*.mp4 -o -iname \*.avi -o -iname \*.mkv \) \
        -exec bash -c "__mp4c \"$2\" \"{}\"" \;
    }
  fi

# backup commands
  if which rsync &> /dev/null; then
    backup_root() {
      sudo rsync -axhH --numeric-ids --delete --progress \
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
        / "node99:/array0/backup/${HOSTNAME}/"
    }
    backup_array0() {
      mountpoint -q /array2 && sudo rsync -axhH \
        --numeric-ids --delete --progress \
        --exclude "chroot*/array*/*" \
        --exclude "chroot*/backup/*" \
        --exclude "chroot*/dev/*" \
        --exclude "chroot*/export/*" \
        --exclude "chroot*/media/*" \
        --exclude "chroot*/mnt/*" \
        --exclude "chroot*/proc/*" \
        --exclude "chroot*/run/*" \
        --exclude "chroot*/swapfile" \
        --exclude "chroot*/sys/*" \
        --exclude "chroot*/tmp/*" \
        --exclude "chroot*/var/run/*" \
        --exclude "chroot*/var/tmp/*" \
        /array0/ /array2/
    }
  fi
