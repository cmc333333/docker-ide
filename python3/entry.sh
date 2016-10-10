#!/bin/sh

# User/permissions setup
: "${USER_ID:?Use -e USER_ID=\`id -u \$USER\` when running docker}"
useradd --home /home -M --uid $USER_ID user
chown user:user -R /home

su user -c "/home/vimwrapper.sh $@"
