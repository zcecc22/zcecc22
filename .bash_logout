# ~/.bash_logout

kill $(pidof gpg-agent) &> /dev/null

if [ "$SHLVL" = 1 ]; then
  [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
