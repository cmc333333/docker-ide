#!/bin/bash
set -euo pipefail
cd /usr/src/workspace
source /home/.bashrc

# install pyenv
if [ ! -d /usr/src/pyenv ]; then
  git clone https://github.com/yyuu/pyenv.git /usr/src/pyenv --depth=1
  mkdir -p ${IDE_CACHE_DIR}pyenv-versions/
  ln -s ${IDE_CACHE_DIR}pyenv-versions /usr/src/pyenv/versions
  echo 'eval "$(pyenv init -)"' >> /home/.bashrc
  echo 'eval "$(pyenv init --path)"' >> /home/.bashrc
  source /home/.bashrc
fi

# select python version
if [ ! -f .python-version ] && [ ! -f ../.python-version ]; then
  versions=$(pyenv install --list | tail -n +1)
  printf "$versions\n$versions\n" | sort \
    | xargs whiptail --notags --menu "Which Python Version?" 0 0 0 \
    2> ../.python-version
fi

# install that version
if ! pyenv versions 2> /dev/null; then
  version_file=$(pyenv version-file)
  version=$(cat $version_file)
  pyenv install $version
  pyenv rehash
  pip install --upgrade pip
fi

if ! pip freeze | grep pipenv > /dev/null; then
  pip install pipenv
fi

# set up a Pipfile
if [ ! -f Pipfile ] && [ ! -f ../Pipfile ]; then
  touch ../Pipfile
  echo "export PIPENV_PIPFILE=/usr/src/Pipfile" >> /home/.bashrc
  source /home/.bashrc
fi

desired_deps=( black flake8 isort python-lsp-server mypy )
current_deps=$(pipenv run pip freeze)
for desired in "${desired_deps[@]}"
do
  if ! echo "$current_deps" | grep "$desired" > /dev/null; then
    pipenv run pip install $desired
  fi
done

# vim should run within the pipenv shell
if ! grep pipenv /usr/bin/vim-wrapper.sh > /dev/null; then
  # Can't use -i due to limited permissions
  sed 's/vim/pipenv run vim/g' /usr/bin/vim-wrapper.sh > /tmp/vim-wrapper.sh
  cp /tmp/vim-wrapper.sh /usr/bin/vim-wrapper.sh
  rm /tmp/vim-wrapper.sh
  echo "You must restart the IDE to use pipenv"
fi
