#!/bin/bash -x

# update package database
sudo apt update

# neovim
mkdir -p /home/yuta/nvim/
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage > /home/yuta/nvim/
sudo chmod u+x nvim.appimage
sudo ln -s /home/yuta/nvim/nvim.appimage /usr/local/bin/nvim

# python3 provider
sudo add-apt-repository universe
sudo apt install python3-pip
pip3 install --user --upgrade pynvim

# plug.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# ripgrep
sudo apt install ripgrep

# fd
sudo apt install fd-find
mkdir -p ~/.local/bin
sudo ln -s $(which fdfind) ~/.local/bin/fd

# nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source ~/.bashrc
nvm install node

exit
