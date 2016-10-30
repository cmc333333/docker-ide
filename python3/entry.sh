#!/bin/sh

# User/permissions setup
: "${USER_ID:?Use -e USER_ID=\`id -u \$USER\` when running docker}"
useradd --home /home -M --uid $USER_ID user
chown user:user -R /home

sudo -u user /home/vimwrapper.sh $@
