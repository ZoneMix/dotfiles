#!/bin/bash
printf '\n\nUpdating and Upgrading...'
sleep 1

sudo apt update && sudo apt update --fix-missing && sudo apt upgrade -y
sudo apt install neovim curl python3-all python3-pip tmux zsh gcc terminator gdb gdb-multiarch qemu-user qemu-system qemu-user-static gcc-aarch64-linux-gnu gcc-arm-linux-gnueabi gcc-arm-linux-gnueabihf gcc-arm-none-eabi binutils-aarch64-linux-gnu binutils-arm-linux-gnueabihf build-essential bochs git vim -y

printf '\n\nInstalling dotfiles\n'
sleep 1
git clone https://github.com/ZoneMix/dotfiles.git $HOME/dotfiles --recursive --recurse-submodules
cd $HOME/dotfiles

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

curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

printf '\n\nInstalling Oh-My-Zsh...\n'

curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

mkdir -p $HOME/.config/nvim

echo 'source $HOME/dotfiles/nvim/init.vim' > $HOME/.config/nvim/init.vim

printf '\n\nInstalling plugins for nvim...\n'
sleep 1
nvim +PlugInstall +PlugUpdate +qall

echo 'source $HOME/dotfiles/zsh/zshrc.sh' > $HOME/.zshrc

rmdir $HOME/dotfiles/zsh/plugins/zsh-syntax-highlighting
rmdir $HOME/dotfiles/zsh/plugins/zsh-autosuggestions
rmdir $HOME/dotfiles/zsh/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/dotfiles/zsh/plugins/zsh-syntax-highlighting > /dev/null
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/dotfiles/zsh/plugins/zsh-autosuggestions > /dev/null
git clone https://github.com/romkatv/powerlevel10k.git $HOME/dotfiles/zsh/themes/powerlevel10k > /dev/null

mkdir -p $HOME/.fonts
cd $HOME/.fonts
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

sudo fc-cache -v

cd $HOME
source .zshrc
reset
zsh
