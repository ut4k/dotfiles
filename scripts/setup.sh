#!/bin/bash -x

# update package database
# sudo apt update

# neovim
mkdir -p /home/yuta/nvim/
curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage --output /home/yuta/nvim/nvim.appimage
sudo chmod u+x /home/yuta/nvim/nvim.appimage
sudo rm -rf /usr/local/bin/nvim
sudo ln -s /home/yuta/nvim/nvim.appimage /usr/local/bin/nvim

# python3 provider
sudo add-apt-repository universe
sudo apt install python3-pip
pip3 install --user --upgrade pynvim

# plug.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# ripgrep
sudo apt install ripgrep

# fzf
sudo apt install fzf

# fd
sudo apt install fd-find
mkdir -p ~/.local/bin
sudo ln -s $(which fdfind) ~/.local/bin/fd

# nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source ~/.bashrc
nvm install node

exit
