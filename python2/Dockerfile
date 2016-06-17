FROM alpine:3.4
MAINTAINER CM Lubinski <cm.lubinski@gmail.com>

# Common packages
RUN apk add --update git openssh python \
    && rm -rf /var/cache/apk/*

# Compile Vim with relevant options
RUN apk add --update build-base ncurses-dev python-dev \
    && cd /tmp \
    && git clone --depth=1 https://github.com/vim/vim.git \
    && cd vim \
    && ./configure --with-features=normal --enable-multibyte \
                   --disable-netbeans --with-compiledby="CM Lubinski" \
                   --enable-pythoninterp=dynamic \
    && make install \
    && apk del --purge build-base ncurses-dev python-dev \
    && cd /tmp && rm -rf /var/cache/apk/* /tmp/vim

# Libxml
RUN apk add --update libxslt libxml2-dev libxslt-dev gcc python-dev musl-dev \
    && rm -rf /var/cache/apk/*

# Directory setup
RUN mkdir -p /home/.vim/autoload /home/.vim/bundle /workdir

# Plugins
RUN apk add --update curl py-pip \
    && curl -Lo /home/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim \
    && cd /home/.vim/bundle \
    && git clone --depth=1 https://github.com/bling/vim-airline.git \
    && git clone --depth=1 https://github.com/davidhalter/jedi-vim.git \
    && git clone --depth=1 https://github.com/ervandew/supertab.git \
    && git clone --depth=1 https://github.com/edsono/vim-matchit.git \
    && git clone --depth=1 https://github.com/scrooloose/nerdtree.git \
    && git clone --depth=1 https://github.com/scrooloose/syntastic.git \
    && git clone --depth=1 https://github.com/tpope/vim-commentary.git \
    && git clone --depth=1 https://github.com/tpope/vim-fugitive.git \
    && git clone --depth=1 https://github.com/tpope/vim-repeat.git \
    && git clone --depth=1 https://github.com/tpope/vim-speeddating.git \
    && git clone --depth=1 https://github.com/tpope/vim-surround.git \
    && pip install jedi virtualenv \
    && apk del --purge curl py-pip \
    && rm -rf /var/cache/apk/*

COPY ["vimrc", "/home/.vimrc"]
COPY ["gitconfig", "/home/.gitconfig"]
COPY ["gitignore", "/home/.gitignore"]
COPY ["entry.sh", "/home/entry.sh"]

ENV TERM='xterm-256color' \
    PAGER='less' \
    EDITOR='vim' \
    PYTHONUNBUFFERED='1'

WORKDIR /workdir/
ENTRYPOINT ["/home/entry.sh"]
