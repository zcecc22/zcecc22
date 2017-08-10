# ~/.bash_profile

gpg-agent --daemon --enable-ssh-support &> /dev/null
[ -f $HOME/.bashrc ] && source $HOME/.bashrc
