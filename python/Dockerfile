FROM alpine:3.4
MAINTAINER CM Lubinski <cm.lubinski@gmail.com>

COPY ["setup.sh", "/root/"]

RUN /root/setup.sh

COPY [".ackrc", ".gitconfig", ".gitignore", ".vimrc", "entry.sh", "vimwrapper.sh", "/home/"]

VOLUME ["/home/history", "/home/.ssh", "/workdir", "/pyenv/cache"]
ENTRYPOINT ["/home/entry.sh"]
WORKDIR /workdir/
EXPOSE 8000
