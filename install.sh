#!/bin/bash
cd ~/dotfiles

printf '\n\nUpdating and Upgrading...'
sleep 1

sudo apt update && apt upgrade -y
sudo apt install neovim curl python3-all python3-pip tmux zsh gcc terminator libc6-i386 libc6-mipsel-cross libc6-armel-cross gdb gdb-multiarch qemu-user qemu-system qemu-user-static gcc-aarch64-linux-gnu gcc-arm-linux-gnueabi gcc-arm-linux-gnueabihf gcc-arm-none-eabi binutils-aarch64-linux-gnu binutils-arm-linux-gnueabihf build-essential bochs git vim -y

printf '\n\nInstalling pip packages\n'
sleep 1
pip3 install pynvim ropper keystone-engine pwntools

printf '\n\nInstalling gef'
sleep 1
wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh

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

sudo fc-cache -v

cd ~
source .zshrc
reset
zsh
