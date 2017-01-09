FROM alpine:3.4
MAINTAINER CM Lubinski <cm.lubinski@gmail.com>

# Common packages
RUN apk add --update git openssh python curl \
    && rm -rf /var/cache/apk/*

# Compile Vim with relevant options
RUN apk add --update build-base ncurses-dev python-dev diffutils \
    && cd /tmp \
    && git clone --depth=1 https://github.com/vim/vim.git \
    && cd vim \
    && ./configure --with-features=normal --enable-multibyte \
                   --disable-netbeans --with-compiledby="CM Lubinski" \
                   --enable-pythoninterp=dynamic \
    && make install \
    && apk del --purge build-base ncurses-dev python-dev \
    && cd /tmp && rm -rf /var/cache/apk/* /tmp/vim

# Compile Nim
RUN apk add --update gcc musl-dev tar gzip \
    && cd /tmp \
    && curl -Lo /tmp/nim.tgz https://github.com/nim-lang/Nim/archive/v0.14.2.tar.gz \
    && tar -xvzf nim.tgz \
    && mv Nim-0.14.2 /etc/nim \
    && cd /etc/nim \
    && git clone --depth=1 https://github.com/nim-lang/csources.git \
    && cd csources && sh build.sh \
    && cd .. \
    && ./bin/nim compile koch \
    && ./koch boot -d:release \
    && chmod a+x /etc/nim/bin/nim \
    && apk del --purge musl-dev tar gzip \
    && rm -rf /var/cache/apk/* /etc/nim/csources

ENV PATH $PATH:/etc/nim/bin/

# Compile nimble
RUN apk add --update libc-dev \
    && cd /tmp \
    && git clone --depth=1 https://github.com/nim-lang/nimble.git \
    && cd nimble \
    && mkdir -p /etc/nimble /root/.config/nimble/ /home/.config/nimble/ \
    && echo 'nimbleDir = r"/etc/nimble/"' >> /root/.config/nimble/nimble.ini \
    && nim -d:release compile -r src/nimble -y install \
    && cd / \
    && rm -rf /var/cache/apk/* /tmp/*

ENV PATH $PATH:/workdir/.nimble-lib/bin

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
    && git clone --depth=1 https://github.com/zah/nim.vim.git

COPY ["vimrc", "/home/.vimrc"]
COPY ["gitconfig", "/home/.gitconfig"]
COPY ["gitignore", "/home/.gitignore"]
COPY ["entry.sh", "/home/entry.sh"]

ENV TERM='xterm-256color' \
    PAGER='less' \
    EDITOR='vim'

WORKDIR /workdir/
ENTRYPOINT ["/home/entry.sh"]
