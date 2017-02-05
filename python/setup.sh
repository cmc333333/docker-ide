#!/bin/sh

# Core packages
apk add --update bash \
                 curl \
                 diffutils \
                 git \
                 grep \
                 openssh \
                 patch \
                 sudo

# Python Dev Packages
apk add --update build-base \
                 bzip2-dev \
                 expat-dev \
                 gdbm-dev \
                 libbz2 \
                 libc6-compat \
                 libffi-dev \
                 linux-headers \
                 ncurses-dev \
                 openssl-dev \
                 patch \
                 paxmark \
                 readline-dev \
                 sqlite-dev \
                 tcl-dev \
                 xz-dev \
                 zlib-dev

# Libxml
apk add --update libxslt libxml2-dev libxslt-dev

# Fetch pyenv
git clone https://github.com/yyuu/pyenv.git /pyenv --depth=1
# Prep for project-specific version installation
ln -s /workdir/.ide/pyenv/versions/ /pyenv/versions
ln -s /workdir/.ide/pyenv/shims/ /pyenv/shims

# Build Vim
apk add --update python2-dev py2-pip python3-dev  # for +python, +python3
cd /tmp
git clone --depth=1 https://github.com/vim/vim.git
cd vim
./configure --with-features=huge --enable-multibyte \
            --disable-netbeans --with-compiledby="CM Lubinski" \
            --enable-pythoninterp --enable-python3interp
make install
cd /
rm -rf /tmp/vim
pip2 install jedi
pip3 install jedi

# Directory setup
mkdir -p /home/.vim/autoload /home/.vim/bundle /workdir

# Plugins
curl -Lo /home/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cd /home/.vim/bundle
git clone --depth=1 https://github.com/bling/vim-airline.git
git clone --depth=1 https://github.com/davidhalter/jedi-vim.git
git clone --depth=1 https://github.com/ervandew/supertab.git
git clone --depth=1 https://github.com/jwhitley/vim-matchit.git
git clone --depth=1 https://github.com/scrooloose/nerdtree.git
git clone --depth=1 https://github.com/scrooloose/syntastic.git
git clone --depth=1 https://github.com/tpope/vim-commentary.git
git clone --depth=1 https://github.com/tpope/vim-fugitive.git
git clone --depth=1 https://github.com/tpope/vim-repeat.git
git clone --depth=1 https://github.com/tpope/vim-speeddating.git
git clone --depth=1 https://github.com/tpope/vim-surround.git
git clone --depth=1 https://github.com/lambdalisue/vim-pyenv.git

# Cleanup
rm -rf /var/cache/apk/*
