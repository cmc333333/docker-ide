#!/bin/sh

# User/permissions setup
: "${USER_ID:?Use -e USER_ID=\`id -u \$USER\` when running docker}"
adduser -h /home -D -H -u $USER_ID user
chown user:user -R /home
chown user:user -R /pyenv/cache

sudo -u user /home/vimwrapper.sh $@
