#!/bin/bash
# avoid set -eo pipefail as nvm may contain errors
source /home/.bashrc
cd /usr/src/workspace

# install nvm
if [ -n ${NVM_DIR} ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
  source /home/.bashrc
  mkdir -p ${IDE_CACHE_DIR}nvm-cache ${IDE_CACHE_DIR}nvm-versions
  ln -s ${IDE_CACHE_DIR}nvm-cache ${NVM_DIR}/.cache
  ln -s ${IDE_CACHE_DIR}nvm-versions ${NVM_DIR}/versions
fi

if [ ! -x python ]; then
  sudo apt update
  sudo apt install -y python-is-python3 python3-distutils
  sudo rm -rf /var/lib/apt/lists/*
fi

# select node version
if [ ! -f .nvmrc ] && [ ! -f ../.nvmrc ]; then
  versions=$(nvm ls-remote | tr -s ' ' | cut -d ' ' -f 2)
  printf "$versions\n$versions\n" | sort --reverse \
    | xargs whiptail --notags --menu "Which Node Version?" 0 0 0 \
    2> ../.nvmrc
fi

# ensure that version is installed
nvm install

# setup vim plugins
VIM_PLUGIN_DIR=/usr/share/vim/vimfiles/pack/plugins/start/
if [ ! -d ${VIM_PLUGIN_DIR}vim-graphql ]; then
  sudo git clone --depth=1 https://github.com/jparise/vim-graphql.git ${VIM_PLUGIN_DIR}vim-graphql
  sudo vim -es -c "packloadall" -c "helptags ALL" -c "q"
fi
if [ ! -d ${VIM_PLUGIN_DIR}vim-jsx-pretty ]; then
  sudo git clone --depth=1 https://github.com/MaxMEllon/vim-jsx-pretty.git ${VIM_PLUGIN_DIR}vim-jsx-pretty
  sudo vim -es -c "packloadall" -c "helptags ALL" -c "q"
fi
if [ ! -d ${VIM_PLUGIN_DIR}typescript-vim ]; then
  sudo git clone --depth=1 https://github.com/leafgarland/typescript-vim.git ${VIM_PLUGIN_DIR}typescript-vim
  sudo vim -es -c "packloadall" -c "helptags ALL" -c "q"
fi
