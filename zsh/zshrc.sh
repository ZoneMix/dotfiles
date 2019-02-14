export ZSH=~/dotfiles/zsh
TERM=screen-256color
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_THEME="avit"
source $ZSH/oh-my-zsh.sh

function asmc(){
	nasm -f macho64 $1
	ld -macosx_version_min 10.7.0 -lSystem -o ${$1%.*} ${$1%.*}.o
}
function gpp(){
	echo "g++ -std=c++11 -o $(echo "$1" | cut -d . -f 1) $1"
	g++ -std=c++11 -o $(echo "$1" | cut -d . -f 1) $1
}
alias love="/Applications/love.app/Contents/MacOS/love"
fortune | cowsay | lolcat
