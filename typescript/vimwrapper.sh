#!/bin/bash

export LANG=en_US.UTF-8
export PATH=./node_modules/.bin/:$PATH

# Warn if empty directory
if [ $# -eq 0 ] && [ ! "$(ls)" ]
then
  echo 'Directory is empty. Did you mount one via -v "$PWD":/workdir/ ?'
fi

# other env variables
export TERM='xterm-256color'
export PAGER='less'
export EDITOR='vim'

# start vim
vim -i /home/history/viminfo $@
