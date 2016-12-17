# Warn if empty directory
if [ $# -eq 0 ] && [ ! "$(ls)" ]
then
  echo 'Directory is empty. Did you mount one via -v "$PWD":/workdir/ ?'
fi

export PATH="./node_modules/.bin:$PATH"

# start vim
vim -i /home/history/viminfo $@


