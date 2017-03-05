FROM ubuntu:xenial
MAINTAINER CM Lubinski <cm.lubinski@gmail.com>

COPY ["setup.sh", "/root/"]

RUN /root/setup.sh

COPY [".vimrc", ".gitconfig", ".gitignore", "entry.sh", "vimwrapper.sh", "/home/"]

VOLUME ["/home/history", "/home/.ssh", "/workdir", "/nvm/alias", "/nvm/versions"]
ENTRYPOINT ["/home/entry.sh"]
WORKDIR /workdir/
EXPOSE 8000
