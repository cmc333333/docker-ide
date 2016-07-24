#!/bin/sh

# User/permissions setup
: "${USER_ID:?Use -e USER_ID=\`id -u \$USER\` when running docker}"
adduser -h /home -D -H -u $USER_ID user
chown user:user -R /home

# Warn if empty directory
if [ $# -eq 0 ] && [ ! "$(ls)" ]
then
  echo 'Directory is empty. Did you mount one via -v "$PWD":/workdir/ ?'
fi

# create nimble
if [ ! -d .nimble ]
then
  echo 'No nimble directory. Creating one.'
  su user -c "cp -r /etc/nimble .nimble"
fi

ln -s /workdir/.nimble /home/.nimble

# start vim
su user -c "vim -i /home/history/viminfo $@"
