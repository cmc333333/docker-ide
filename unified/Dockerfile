FROM alpine:3.11
MAINTAINER CM Lubinski <cm.lubinski@gmail.com>

# Core packages
RUN apk add --no-cache ack bash vim sudo

# pyenv
RUN apk add --no-cache \
  build-base bzip2-dev expat-dev gdbm-dev git libbz2 libc6-compat libffi-dev \
  linux-headers ncurses-dev openssl openssl-dev patch paxmark python3-dev \
  readline-dev sqlite-dev tcl-dev xz-dev zlib-dev
RUN git clone https://github.com/yyuu/pyenv.git /pyenv --depth=1

# pipenv (installed in a system python)
RUN apk add --no-cache python3 && pip3 install pipenv

# vim plugins and setup
RUN mkdir -p /usr/share/vim/vimfiles/pack/plugins/start
RUN git clone --depth=1 https://github.com/bling/vim-airline.git /usr/share/vim/vimfiles/pack/plugins/start/airline
RUN git clone --depth=1 https://github.com/ervandew/supertab.git /usr/share/vim/vimfiles/pack/plugins/start/supertab
RUN git clone --depth=1 https://github.com/jwhitley/vim-matchit.git /usr/share/vim/vimfiles/pack/plugins/start/matchit
RUN git clone --depth=1 https://github.com/mileszs/ack.vim.git /usr/share/vim/vimfiles/pack/plugins/start/ack
RUN git clone --depth=1 https://github.com/plasticboy/vim-markdown.git /usr/share/vim/vimfiles/pack/plugins/start/markdown
RUN git clone --depth=1 https://github.com/scrooloose/nerdtree.git /usr/share/vim/vimfiles/pack/plugins/start/nerdtree
RUN git clone --depth=1 https://github.com/tomtom/tcomment_vim.git /usr/share/vim/vimfiles/pack/plugins/start/tcomment
RUN git clone --depth=1 https://github.com/tpope/vim-fugitive.git /usr/share/vim/vimfiles/pack/plugins/start/fugitive
RUN git clone --depth=1 https://github.com/tpope/vim-repeat.git /usr/share/vim/vimfiles/pack/plugins/start/repeat
RUN git clone --depth=1 https://github.com/tpope/vim-speeddating.git /usr/share/vim/vimfiles/pack/plugins/start/speeddating
RUN git clone --depth=1 https://github.com/tpope/vim-surround.git /usr/share/vim/vimfiles/pack/plugins/start/surround
RUN git clone --depth=1 https://github.com/w0rp/ale.git /usr/share/vim/vimfiles/pack/plugins/start/ale
RUN mkdir -p /usr/share/vim/vimfiles/pack/plugins/start/custom
COPY ["ftplugin/", "/usr/share/vim/vimfiles/pack/plugins/start/custom/ftplugin/"]
RUN vim -es -c "packloadall" -c "helptags ALL" -c "q"

COPY ["gitconfig", "gitignore", "profile", "/etc/"]

RUN echo "user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user
COPY ["entrypoint.sh", ".vimrc", "/home/"]
RUN chmod a+w /home /home/.vimrc

VOLUME ["/home/.ssh", "/ide", "/workdir", "/pyenv/versions"]
WORKDIR /workdir/
