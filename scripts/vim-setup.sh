#!/bin/bash

#########################################
# plug.vim
#########################################

#path of plug.vim
VIMPLUGPATH=~/.vim/autoload/plug.vim

#download plug.vim if not exists
if [[ ! -e "$VIMPLUGPATH" ]]; then
  curl -fLo "$VIMPLUGPATH" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo "plug.vim installed"
fi

#########################################
# nodejs
#########################################

if ! type nodejs > /dev/null; then
  echo "please install nodejs"
fi


exit
