export ZSH=~/dotfiles/zsh
TERM=xterm-256color-italic
export EDITOR=nvim
export PATH=/Users/blake/.nimble/bin:$PATH

source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

autoload -Uz add-zsh-hook
_nicy_prompt() {
	#PROMPT=$(~/.nimble/bin/nicy)
	PROMPT=$(~/.nimble/pkgs/nicy-2.4.2/nicy2)
}
add-zsh-hook precmd _nicy_prompt

#source $ZSH/oh-my-zsh.sh

#local _return_status="%(?.., %{$fg_bold[red]%}⍉)%{$reset_color%}"
#local _current_dir="%{$fg_bold[blue]%}%3~%{$reset_color%}"

#function preexec() {
  #timer=${timer:-$SECONDS}
#}
#PROMPT="[${_current_dir}%{$fg[$CARETCOLOR]%}%{$resetcolor%}] "
#function precmd() {
	#if [ $timer ]; then
		#timer_show=$(($SECONDS - $timer))
		#if [ $timer_show -gt 0 ]; then
			#PROMPT="[${_current_dir}%{$fg[$CARETCOLOR]%}%{$resetcolor%}${_return_status}, %F{magenta}${timer_show}s%{$reset_color%}] "
		#else
			#PROMPT="[${_current_dir}%{$fg[$CARETCOLOR]%}%{$resetcolor%}${_return_status}] "
		#fi
		#unset timer
	#fi
#}

#PROMPT='[$(_user_host)${_current_dir}%{$fg[$CARETCOLOR]%}%{$resetcolor%}] '

rmd () {
	pandoc $1 | lynx -stdin
}

calc () {
	~/dotfiles/scripts/calc/calc $@
}

gitclone () {
	repo=${1#*/}
	if [ $repo = $1 ]
	then
		git clone https://github.com/blakeanedved/$repo ~/Documents/Projects/$repo
	else
		git clone https://github.com/$1 ~/Documents/Projects/$repo
	fi
	chmod -R 774 ~/Documents/Projects/$repo
	cd ~/Documents/Projects/$repo
}

github () {
	repo=${1#*/}
	if [ $repo = $1 ]
	then
		open https://github.com/blakeanedved/$1
	else
		open https://github.com/$1
	fi
}

search () {
	searchstr="https://duckduckgo.com/?q="
	first=1
	for var in "$@"
	do
		if [[ $first == 1 && ($var == "w" || $var == "imdb" || $var == "a" || $var == "e" || $var == "so" || $var == "gh" || $var == "zillow" || $var == "tw" || $var == "li" || $var == "r" || $var == "ste" || $var == "nf" || $var == "p" || $var == "wa" || $var == "yt" || $var == "g" || $var == "cpp" || $var == "rust" || $var == "py" || $var == "py3") ]]
		then
			var="!$var"
		fi
		first=0
		searchstr="$searchstr$var+"
	done

	searchstr=${searchstr%?}

	open "$searchstr"
}

docs () {
	searchstr="https://duckduckgo.com/?q="
	first=1
	for var in "$@"
	do
		if [[ $first == 1 && ($var == "cpp" || $var == "py" || $var == "python" || $var == "py3" || $var == "python3" || $var == "rust" || $var == "js") ]]
		then
			if [[ $var == "c++" ]]
			then
				var="cpp"
			fi
			var="!$var"
		fi
		first=0
		searchstr="$searchstr$var+"
	done

	searchstr=${searchstr%?}

	open "$searchstr"
}

rand () {
	python3 ~/dotfiles/scripts/rand.py $@
}

alias projector='python3 ~/dotfiles/scripts/projector/projector.py'
alias proj='python3 ~/dotfiles/scripts/projector/projector.py'
alias p='python3 ~/dotfiles/scripts/projector/projector.py'

alias tmux="env TERM=screen-256color-italic tmux"

alias ga="git add ."
alias gc="git commit"
alias gp="git push -u origin master"

alias vim="nvim"

alias skim="open -a Skim"

alias vimrc="vim ~/dotfiles/nvim/init.vim"
alias tmuxrc="vim ~/dotfiles/tmux/tmux.conf"
alias zshrc="vim ~/dotfiles/zsh/zshrc.sh"

alias ls="exa"

alias server="browser-sync start --server --files '**/*.html' '**/*.css' '**/*.js'"

alias now="date +'%l:%M%p'"

alias setclass="sh ~/dotfiles/scripts/makelink"

hash -d nvim=$HOME/dotfiles/nvim
hash -d zsh=$HOME/dotfiles/zsh
hash -d tmux=$HOME/dotfiles/tmux
hash -d kattis=$HOME/Documents/School/Programming\ Club/Kattis
hash -d p=$HOME/Documents/Projects/
hash -d s=$HOME/Documents/School/
hash -d proglangs=$HOME/Documents/School/CSC-461/
hash -d parallel=$HOME/Documents/School/CSC-410/
hash -d ood=$HOME/Documents/School/CSC-260/
hash -d softsec=$HOME/Documents/School/CSC-234/
