#!/bin/bash
source /home/.bashrc

# User/permissions setup
: "${USER_ID:?Use -e USER_ID=\`id -u \$USER\` when running docker}"
adduser --home /home --disabled-password --no-create-home --uid $USER_ID --gecos "" user > /dev/null
chown user:user -R /home/ /usr/src/ /usr/bin/vim-wrapper.sh ${IDE_CACHE_DIR}

sudo --user user vim-wrapper.sh $@

deluser user &> /dev/null
