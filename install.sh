#!/bin/bash
cd ~/dotfiles

printf '\n\nUpdating and Upgrading...'
sleep 1

sudo apt update && apt upgrade -y
sudo apt install neovim curl python3-all python3-pip tmux zsh git -y

printf '\n\nInstalling pynvim...\n'
sleep 1
pip install pynvim
pip3 install pynvim

printf '\n\nChanging default shell to ZSH shell...\n'
chsh -s $(which zsh)

printf '\n\nInstalling Plug for nvim...\n'
sleep 1

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

printf '\n\nInstalling Oh-My-Zsh...\n'

curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh

mkdir -p ~/.config/nvim

echo 'source ~/dotfiles/nvim/init.vim' > ~/.config/nvim/init.vim

printf '\n\nInstalling plugins for nvim...\n'
sleep 1
nvim +PlugInstall +PlugUpdate +qall
sudo fc-cache -v

echo 'source ~/dotfiles/zsh/zshrc.sh' > ~/.zshrc

