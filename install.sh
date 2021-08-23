#!/bin/bash
cd ~/dotfiles

printf '\n\nInstalling pip packages\n'
sleep 1
pip3 install pynvim

printf '\n\nChanging default shell to ZSH shell...\n'
sleep 1
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

echo 'source ~/dotfiles/zsh/zshrc.sh' > ~/.zshrc

rmdir ~/dotfiles/zsh/plugins/zsh-syntax-highlighting
rmdir ~/dotfiles/zsh/plugins/zsh-autosuggestions
rmdir ~/dotfiles/zsh/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/dotfiles/zsh/plugins/zsh-syntax-highlighting > /dev/null
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/dotfiles/zsh/plugins/zsh-autosuggestions > /dev/null
git clone https://github.com/romkatv/powerlevel10k.git ~/dotfiles/zsh/themes/powerlevel10k > /dev/null

mkdir -p ~/.fonts
cd ~/.fonts
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

cd ~
source .zshrc
reset
zsh
