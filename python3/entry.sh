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

# create virtualenv
if [ ! -d .venv ]
then
  echo 'No virtualenv; creating one. This may take a moment'
  su user -c "virtualenv .venv"
fi

# activate virtualenv
export VIRTUAL_ENV="/workdir/.venv"
export PATH="$VIRTUAL_ENV/bin:$PATH"
unset PYTHON_HOME

# start vim
su user -c "vim -i /home/history/viminfo $@"
