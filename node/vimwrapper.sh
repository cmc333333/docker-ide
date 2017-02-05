#!/bin/bash

export LANG=en_US.UTF-8

# Warn if empty directory
if [ $# -eq 0 ] && [ ! "$(ls)" ]
then
  echo 'Directory is empty. Did you mount one via -v "$PWD":/workdir/ ?'
fi

# Load NVM
export NVM_DIR="/nvm"
. "$NVM_DIR/nvm.sh"

# create Node info
if [ ! -f .nvmrc ]
then
  if [ ! -f .ide/.node-version ]
  then
    mkdir -p .ide
    echo "Available versions:"
    nvm ls-remote
    read -p 'What version of Node should we use? ' nodeversion
    echo $nodeversion >> ".ide/.node-version"
  fi
fi

export nodeversion=`(cat .nvmrc 2> /dev/null) || cat .ide/.node-version`

(nvm ls $nodeversion > /dev/null) || (nvm install $nodeversion > /dev/null)

nvm use $nodeversion > /dev/null

# other env variables
export TERM='xterm-256color'
export PAGER='less'
export EDITOR='vim'

# start vim
vim -i /home/history/viminfo $@
