#!/bin/sh

# User/permissions setup
: "${USER_ID:?Use -e USER_ID=\`id -u \$USER\` when running docker}"
useradd --home-dir /home -M --uid $USER_ID user
chown user:user -R /home
chown user:user -R /nvm

sudo -u user -H /home/vimwrapper.sh $@
