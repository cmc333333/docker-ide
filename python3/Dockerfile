FROM python:3.5
MAINTAINER CM Lubinski <cm.lubinski@gmail.com>

# Common packages
RUN apt-get update \
    && apt-get -y install git openssh-client sudo \
    && rm -rf /var/lib/apt/lists/*

# Compile Vim with relevant options
RUN cd /tmp \
    && git clone --depth=1 https://github.com/vim/vim.git \
    && cd vim \
    && ./configure --with-features=normal --enable-multibyte \
                   --disable-netbeans --with-compiledby="CM Lubinski" \
                   --enable-python3interp=dynamic \
    && make install \
    && cd /tmp && rm -rf /tmp/vim


# Directory setup
RUN mkdir -p /home/.vim/autoload /home/.vim/bundle /workdir

# Plugins
RUN curl -Lo /home/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim \
    && cd /home/.vim/bundle \
    && git clone --depth=1 https://github.com/bling/vim-airline.git \
    && git clone --depth=1 https://github.com/davidhalter/jedi-vim.git \
    && git clone --depth=1 https://github.com/ervandew/supertab.git \
    && git clone --depth=1 https://github.com/jwhitley/vim-matchit.git \
    && git clone --depth=1 https://github.com/scrooloose/nerdtree.git \
    && git clone --depth=1 https://github.com/scrooloose/syntastic.git \
    && git clone --depth=1 https://github.com/tpope/vim-commentary.git \
    && git clone --depth=1 https://github.com/tpope/vim-fugitive.git \
    && git clone --depth=1 https://github.com/tpope/vim-repeat.git \
    && git clone --depth=1 https://github.com/tpope/vim-speeddating.git \
    && git clone --depth=1 https://github.com/tpope/vim-surround.git \
    && pip install flake8 radon

COPY [".vimrc", ".gitconfig", ".gitignore", "entry.sh", "vimwrapper.sh", "/home/"]

WORKDIR /workdir/
ENTRYPOINT ["/home/entry.sh"]
