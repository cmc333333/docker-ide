#!/bin/sh

# User/permissions setup
: "${USER_ID:?Use -e USER_ID=\`id -u \$USER\` when running docker}"
useradd --home /home -M --uid $USER_ID user
chown user -R /home

# Warn if empty directory
if [ $# -eq 0 ] && [ ! "$(ls)" ]
then
  echo 'Directory is empty. Did you mount one via -v "$PWD":/workdir/ ?'
fi

# start vim
su user -c "vim -i /home/history/viminfo $@"
