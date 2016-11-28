# Warn if empty directory
if [ $# -eq 0 ] && [ ! "$(ls)" ]
then
  echo 'Directory is empty. Did you mount one via -v "$PWD":/workdir/ ?'
fi

export PATH="$PATH:./node_modules/.bin"

# start vim
vim -i /home/history/viminfo $@


