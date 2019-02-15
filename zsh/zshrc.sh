export ZSH=~/dotfiles/zsh
#TERM=screen-256color
TERM=xterm-256color
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

#ZSH_THEME="avit"
source $ZSH/oh-my-zsh.sh

local _return_status="%(?.., %{$fg_bold[red]%}⍉)%{$reset_color%}"
local _current_dir="%{$fg_bold[blue]%}%3~%{$reset_color%}"

function preexec() {
  timer=${timer:-$SECONDS}
}
PROMPT="[${_current_dir}%{$fg[$CARETCOLOR]%}%{$resetcolor%}] "
function precmd() {
	if [ $timer ]; then
		timer_show=$(($SECONDS - $timer))
		if [ $timer_show -gt 0 ]; then
			PROMPT="[${_current_dir}%{$fg[$CARETCOLOR]%}%{$resetcolor%}${_return_status}, %F{magenta}${timer_show}s%{$reset_color%}] "
		else
			PROMPT="[${_current_dir}%{$fg[$CARETCOLOR]%}%{$resetcolor%}${_return_status}] "
		fi
		unset timer
	fi
}

#PROMPT='[$(_user_host)${_current_dir}%{$fg[$CARETCOLOR]%}%{$resetcolor%}] '

function asmc(){
	nasm -f macho64 $1
	ld -macosx_version_min 10.7.0 -lSystem -o ${$1%.*} ${$1%.*}.o
}
function gpp(){
	echo "g++ -std=c++11 -o $(echo "$1" | cut -d . -f 1) $1"
	g++ -std=c++11 -o $(echo "$1" | cut -d . -f 1) $1
}
