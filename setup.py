#! /usr/bin/env python3
# The setup script for Bailey Belisario's dotfiles
import os
import sys
import subprocess

subprocess.call([sys.executable, '-m', 'ensurepip'], stdout=subprocess.PIPE)

class PackageManager:
    def __init__(self):
        self.detect_package_manager()

    def install_python_package(self, package):
        print(f'Installing {package}')
        subprocess.call([sys.executable, '-m', 'pip', 'install', package], stdout=subprocess.PIPE)

    def detect_package_manager(self):
         = ('Debian', 'Darwin', )
        pm = subprocess.Popen(['apt-get'], stdout=subprocess.PIPE)
        if pm.stdout.readlines() != []:
            self.pm = 'apt-get'
            return
        pm = subprocess.Popen(['command', '-v', 'brew'], stdout=subprocess.PIPE)
        if pm.stdout.readlines() != []:
            self.pm = 'brew'
            return
        pm = subprocess.Popen(['command', '-v', 'pkg'], stdout=subprocess.PIPE)
        if pm.stdout.readlines() != []:
            self.pm = 'pkg'
            return
        pm = subprocess.Popen(['command', '-v', 'pacman'], stdout=subprocess.PIPE)
        if pm.stdout.readlines() != []:
            self.pm = 'pacman'
            return
    
    def install_system_package(self, package):
        package_exists = True if subprocess.Popen(['command', '-v', package], stdout=subprocess.PIPE).stdout.readlines() != [] else False
        if not package_exists:
            if self.pm == 'apt-get': subprocess.call(['sudo', 'apt-get', 'install', package, '-y'], stdout=subprocess.PIPE)
            elif self.pm == 'brew': subprocess.call(['brew', 'install', package], stdout=subprocess.PIPE)
            elif self.pm == 'pkg': subprocess.call(['sudo', 'pkg', 'install', package], stdout=subprocess.PIPE)
            elif self.pm == 'pacman': subprocess.call(['sudo', 'pacman', '-S', package], stdout=subprocess.PIPE)
            else: print(f'Unreconized package manager, please install {package} with your package manager, then re-run the deployment script')

p = PackageManager()
neovim = False

inp = input('Backup your current dotfiles files? [Y/n]')
if inp != 'n':
    if os.path.isfile(os.path.expanduser('~/.zshrc')):
        subprocess.call(['mv', '~/.zshrc', '~/.zshrc.old'], stdout=subprocess.PIPE)
    if os.path.isfile(os.path.expanduser('~/.tmux.conf')):
        subprocess.call(['mv', '~/.tmux.conf', '~/.tmux.conf.old'], stdout=subprocess.PIPE)
    if os.path.isfile(os.path.expanduser('~/.config/nvim/init.vim')):
        subprocess.call(['mv', '~/.config/nvim/init.vim', '~/.config/nvim/init.vim.old'], stdout=subprocess.PIPE)

inp = input('Would you like to install (neo)vim? [Y/n]')
if inp != 'n':
    p.install_system_package('neovim')
    p.install_python_package('neovim')
    p.install_python_package('pynvim')
    subprocess.call(['curl', '-fLo', '~/.local/share/nvim/site/autoload/plug.vim', '--create-dirs', 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'], stdout=subprocess.PIPE)

    with open(os.path.expanduser('~/.config/nvim/init.vim', 'w+')) as nvimrc:
        nvimrc.write('source "$HOME/dotfiles/nvim/init.vim"')
        nvimrc.truncate()

    subprocess.call(['nvim', '+PlugInstall', '+UpdateRemotePlugins', '+qall'])
    neovim = True

inp = input('Would you like to install zsh? [Y/n]')
if inp != 'n':
    p.install_system_package('zsh')
    inp = input('Would you like to make zsh your default shell? [Y/n]')
    if inp != 'n':
        subprocess.call(['chsh', '-s', '$(which zsh)'], stdout=subprocess.PIPE)

    subprocess.call(['g++', os.path.expanduser('~/dotfiles/scripts/calc/main.cpp'), '-o', os.path.expanduser('~/dotfiles/scripts/calc/calc')])

    inp = input('Install custom nicy prompt? (requires nim) [Y/n]')
    if inp != 'n':
        p.install_system_package('nim')
        subprocess.call(['nimble', 'install', 'nicy'], stdout=subprocess.PIPE)
        subprocess.call(['nim', 'c', os.path.expanduser('~/dotfiles/scipts/prompt/left')])
        subprocess.call(['nim', 'c', os.path.expanduser('~/dotfiles/scipts/prompt/right')])
        subprocess.call(['nim', 'c', os.path.expanduser('~/dotfiles/scipts/prompt/precmd')])
        subprocess.call(['nim', 'c', os.path.expanduser('~/dotfiles/scipts/prompt/preexec')])
        with open(os.path.expanduser('~/dotfiles/zsh/zshrc.sh'), 'a+') as zshrc:
            zshrc.write('autoload -Uz add-zsh-hook\n_nicy_prompt() {\n\tPROMPT=$(~/dotfiles/scripts/prompt/left)\n\tRPROMPT=$(~/dotfiles/scripts/prompt/right)\n}\npreexec () {\n\t~/dotfiles/scripts/prompt/preexec $@\n}\nadd-zsh-hook precmd _nicy_prompt\n')

        print('You must add the line "export GITHUB_USERNAME=\'my_github_username\'" to the top of ~/dotfiles/zsh/zshrc.sh if you want the "github" and "gitclone" commands to work')

inp = input('Would you like to install tmux? [Y/n]')
if inp != 'n':
    p.install_system_package('tmux')

    if neovim:
        print('To fix tmuxline, you must open a tmux session and run "nvim +TmuxlineSnapshot ~/dotfiles/tmux/tmuxline.conf"')
