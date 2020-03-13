#!/bin/sh
source /etc/profile

# User/permissions setup
: "${USER_ID:?Use -e USER_ID=\`id -u \$USER\` when running docker}"
adduser -h /home -D -H -u $USER_ID user
chown user:user -R /home/history

# If no Pipfile exists, point to one to appease pipenv
if [ ! -f Pipfile ]; then
  touch /ide/Pipfile
  export PIPENV_PIPFILE=/ide/Pipfile
  echo "export PIPENV_PIPFILE=/ide/Pipfile" >> /etc/profile
fi

# install the version of python if necessary
if [ -f .python-version ]; then
  pyenv versions | grep `cat .python-version` > /dev/null
  if [ $? -ne 0 ]; then
    pyenv install
  fi
  pyenv rehash
  export PIPENV_PYTHON=/pyenv/shims/python
  echo "export PIPENV_PYTHON=/pyenv/shims/python" >> /etc/profile
fi

pipenv run pip freeze | grep python-language-server > /dev/null
if [ $? -ne 0 ]; then
  pipenv run pip install black flake8 isort python-language-server mypy
fi

chown user:user -R /ide
su -l user -c "cd /workdir; pipenv run vim $@"
