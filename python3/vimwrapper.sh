# Warn if empty directory
if [ $# -eq 0 ] && [ ! "$(ls)" ]
then
  echo 'Directory is empty. Did you mount one via -v "$PWD":/workdir/ ?'
fi

# activate virtualenv
export VIRTUAL_ENV="/workdir/.venv"
export PATH="$VIRTUAL_ENV/bin:$PATH"

# create virtualenv
if [ ! -d .venv ]
then
  echo 'No virtualenv; creating one. This may take a moment'
  pyvenv .venv
  pip install jedi
fi

# start vim
vim -i /home/history/viminfo $@

