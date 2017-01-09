FROM node:6.2-slim
MAINTAINER CM Lubinski <cm.lubinski@gmail.com>

# Common packages
RUN apt-get update \
    && apt-get -y install git openssh-client sudo vim \
    && rm -rf /var/lib/apt/lists/*

# Directory setup
RUN mkdir -p /home/.vim/autoload /home/.vim/bundle /workdir

# Plugins
RUN curl -Lo /home/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim \
    && cd /home/.vim/bundle \
    && git clone --depth=1 https://github.com/bling/vim-airline.git \
    && git clone --depth=1 https://github.com/ervandew/supertab.git \
    && git clone --depth=1 https://github.com/jwhitley/vim-matchit.git \
    && git clone --depth=1 https://github.com/scrooloose/nerdtree.git \
    && git clone --depth=1 https://github.com/scrooloose/syntastic.git \
    && git clone --depth=1 https://github.com/tpope/vim-commentary.git \
    && git clone --depth=1 https://github.com/tpope/vim-fugitive.git \
    && git clone --depth=1 https://github.com/tpope/vim-repeat.git \
    && git clone --depth=1 https://github.com/tpope/vim-speeddating.git \
    && git clone --depth=1 https://github.com/tpope/vim-surround.git \
    && npm install -g eslint

COPY [".vimrc", ".gitconfig", ".gitignore", "entry.sh", "vimwrapper.sh", "/home/"]

ENV TERM='xterm-256color' \
    PAGER='less' \
    EDITOR='vim'

WORKDIR /workdir/
ENTRYPOINT ["/home/entry.sh"]
EXPOSE 8000
