#!/bin/bash

set -e

# Core packages
apt-get update
apt-get install -y ack-grep \
                   curl \
                   git \
                   locales \
                   patch \
                   software-properties-common \
                   sudo

# PPA to get Vim 8
add-apt-repository ppa:jonathonf/vim
apt-get update
apt-get install -y vim

locale-gen en_US.UTF-8
update-locale

# @todo - Dev Packages

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install -g typescript

# Directory setup
mkdir -p /home/.vim/autoload /home/.vim/bundle /workdir

# Plugins
mkdir -p /home/.vim/pack/git-plugins/start
cd /home/.vim/pack/git-plugins/start
git clone https://github.com/w0rp/ale.git ale

curl -Lo /home/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cd /home/.vim/bundle
git clone --depth=1 https://github.com/bling/vim-airline.git
git clone --depth=1 https://github.com/ervandew/supertab.git
git clone --depth=1 https://github.com/jwhitley/vim-matchit.git
git clone --depth=1 https://github.com/leafgarland/typescript-vim.git
git clone --depth=1 https://github.com/mileszs/ack.vim.git
git clone --depth=1 https://github.com/scrooloose/nerdtree.git
git clone --depth=1 https://github.com/tpope/vim-commentary.git
git clone --depth=1 https://github.com/tpope/vim-fugitive.git
git clone --depth=1 https://github.com/tpope/vim-repeat.git
git clone --depth=1 https://github.com/tpope/vim-speeddating.git
git clone --depth=1 https://github.com/tpope/vim-surround.git

apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/apt/*
