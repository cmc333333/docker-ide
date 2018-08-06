#!/bin/bash
export PYENV_ROOT="/pyenv"
export PATH="/pyenv/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PIPENV_VENV_IN_PROJECT=1

# Warn if empty directory
if [ $# -eq 0 ] && [ ! "$(ls)" ]
then
  echo 'Directory is empty. Did you mount one via -v "$PWD":/workdir/ ?'
fi

export PYENV_DIR="/workdir/.ide/"

# create Python info
if [ ! -f .ide/.python-version ]
then
  mkdir -p .ide/pyenv/versions/ .ide/pyenv/shims/ .ide/pyenv/cache/
  echo "Available versions:"
  pyenv install --list | grep -v [a-zA-Z]
  read -p 'What version of Python should we use? ' pyversion
  pyenv install $pyversion
  echo $pyversion >> "/workdir/.ide/.python-version"
fi

eval "$(pyenv init -)"

# other env variables
export TERM='xterm-256color'
export PAGER='less'
export EDITOR='vim'
export PYTHONUNBUFFERED='1'

# start vim
vim -i /home/history/viminfo $@
