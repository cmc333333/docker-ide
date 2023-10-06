FROM ubuntu:20.04
MAINTAINER CM Lubinski <cm.lubinski@gmail.com>

RUN \
  apt-get update &&\
  DEBIAN_FRONTEND=noninteractive TZ=America/New_York \
  apt-get install --yes --no-install-recommends \
    ack\
    build-essential\
    ca-certificates\
    curl\
    git\
    less\
    libbz2-dev\
    libffi-dev\
    liblzma-dev\
    libncurses5-dev\
    libreadline-dev\
    libsqlite3-dev\
    libssl-dev\
    libxml2-dev\
    libxmlsec1-dev\
    llvm\
    locales\
    make\
    sudo\
    tk-dev\
    universal-ctags\
    unzip\
    vim\
    wget\
    whiptail\
    xz-utils\
    zlib1g-dev &&\
  rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8

# vim plugins and setup
RUN \
  mkdir -p /usr/share/vim/vimfiles/pack/plugins/start &&\
  git clone --depth=1 https://github.com/bling/vim-airline.git /usr/share/vim/vimfiles/pack/plugins/start/airline &&\
  git clone --depth=1 https://github.com/ervandew/supertab.git /usr/share/vim/vimfiles/pack/plugins/start/supertab &&\
  git clone --depth=1 https://github.com/frazrepo/vim-rainbow /usr/share/vim/vimfiles/pack/plugins/start/rainbow &&\
  git clone --depth=1 https://github.com/jwhitley/vim-matchit.git /usr/share/vim/vimfiles/pack/plugins/start/matchit &&\
  git clone --depth=1 https://github.com/mileszs/ack.vim.git /usr/share/vim/vimfiles/pack/plugins/start/ack &&\
  git clone --depth=1 https://github.com/plasticboy/vim-markdown.git /usr/share/vim/vimfiles/pack/plugins/start/markdown &&\
  git clone --depth=1 https://github.com/scrooloose/nerdtree.git /usr/share/vim/vimfiles/pack/plugins/start/nerdtree &&\
  git clone --depth=1 https://github.com/tomtom/tcomment_vim.git /usr/share/vim/vimfiles/pack/plugins/start/tcomment &&\
  git clone --depth=1 https://github.com/tpope/vim-fugitive.git /usr/share/vim/vimfiles/pack/plugins/start/fugitive &&\
  git clone --depth=1 https://github.com/tpope/vim-repeat.git /usr/share/vim/vimfiles/pack/plugins/start/repeat &&\
  git clone --depth=1 https://github.com/tpope/vim-speeddating.git /usr/share/vim/vimfiles/pack/plugins/start/speeddating &&\
  git clone --depth=1 https://github.com/tpope/vim-surround.git /usr/share/vim/vimfiles/pack/plugins/start/surround &&\
  git clone --depth=1 https://github.com/w0rp/ale.git /usr/share/vim/vimfiles/pack/plugins/start/ale &&\
  git clone --depth=1 https://github.com/yegappan/taglist.git /usr/share/vim/vimfiles/pack/plugins/start/taglist

RUN mkdir -p /usr/share/vim/vimfiles/pack/plugins/start/custom
COPY ["ftplugin/", "/usr/share/vim/vimfiles/pack/plugins/start/custom/ftplugin/"]
RUN vim -es -c "packloadall" -c "helptags ALL" -c "q"

COPY ["bin/", "/usr/bin/"]
COPY ["home/", "/home/"]
COPY ["etc/", "/etc/"]
# Files in this folder will be shared between IDE instances (e.g. to avoid
# re-building Python)
VOLUME ["/var/cache/ide"]

RUN echo "user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user

WORKDIR /usr/src/workspace/
CMD /bin/entrypoint.sh
