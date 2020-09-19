#!/bin/bash
cd ~/dotfiles

printf '\n\nUpdating and Upgrading...'
sleep 1

sudo apt update && sudo apt upgrade -y > /dev/null
sudo apt install neovim curl python-all python-all-dev python3-all python3-all-dev tmux zsh -y > /dev/null

printf '\n\nInstalling pip and pip3...\n'
sleep 1

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py > /dev/null
chmod u+x get-pip.py
python get-pip.py > /dev/null
python3 get-pip.py > /dev/null

printf '\n\nInstalling pynvim...\n'
sleep 1
pip install pynvim > /dev/null
pip3 install pynvim > /dev/null

printf '\n\nChanging default shell to ZSH shell...\n'
sleep 1
chsh -s $(which zsh)

printf '\n\nInstalling Plug for nvim...\n'
sleep 1

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null

mkdir -p ~/.config/nvim

echo 'source ~/dotfiles/nvim/init.vim' > ~/.config/nvim/init.vim

printf '\n\nInstalling plugins for nvim...\n'
sleep 1
nvim +PlugInstall +PlugUpdate +qall <<< '\n'

echo 'source ~/dotfiles/zsh/zshrc.sh' > ~/.zshrc

rmdir ~/dotfiles/zsh/plugins/zsh-syntax-highlighting
rmdir ~/dotfiles/zsh/plugins/zsh-autosuggestions
rmdir ~/dotfiles/zsh/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/dotfiles/zsh/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/dotfiles/zsh/plugins/zsh-autosuggestions
git clone https://github.com/romkatv/powerlevel10k.git ~/dotfiles/zsh/themes/powerlevel10k

cd ~
source .zshrc
reset

