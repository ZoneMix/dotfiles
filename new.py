import os
import sys
import subprocess

class PackageManager:
    def __init__(self):
        self.detect_package_manager()

    def install_python_package(self, package):
        print(f'Installing {package}')
        subprocess.call([sys.executable, '-m', 'pip3', 'install', package], stdout=subprocess.PIPE)

    def detect_package_manager(self):
        
        userOS = sys.platform
        
        if userOS == 'darwin':
            self.pm = 'brew'
        elif userOS == 'linux':
            if subprocess.call(['apt-get']) == 1:
                self.pm = 'apt-get'
            if subprocess.call(['pkg']) == 1:
                self.pm = 'pkg'
            if subprocess.call(['pacman']) == 1:
                self.pm = 'pacman'
        else:
            print('Unable to detect a package manager for your system')
            quit()
        return
        
    
    def install_system_package(self):
        return 

def main():
    p = PackageManager()
    print('\n========= Installing Dotfiles =========\n')
    
    print('Retrieving dependencies...')

    subprocess.call(['curl', '-fLo', '~/.local/share/nvim/site/autoload/plug.vim', '--create-dirs', 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'])

    return



if __name__ == '__main__':
    main()
