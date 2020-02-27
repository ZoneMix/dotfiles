export ZSH=~/dotfiles/zsh
#export TERM=xterm-256color-italic
#TERM=xterm
export EDITOR=nvim
export ZSH_THEME="powerlevel10k/powerlevel10k"

source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

source $ZSH/oh-my-zsh.sh
export PROJECTOR_PROJECT_FILE='~/.projects'
export PROJECTOR_PROJECTS='~/Documents/Projects'
export PROJECTOR_GITHUB_USERNAME='BaileyBelisario'
export PROJECTOR_TMUX='env TERM=screen-256color-italic tmux'

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

#PROMPT='[${_current_dir}%{$fg[$CARETCOLOR]%}%{$resetcolor%}] '

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


alias tmux="env TERM=screen-256color-italic tmux"
alias vim="nvim"
alias c="clear"
alias vi="nvim"
alias zshrc="vi ~/dotfiles/zsh/zshrc.sh"
#alias ls="exa"
alias projector='python3 ~/dotfiles/scripts/projector/projector.py'
alias proj='python3 ~/dotfiles/scripts/projector/projector.py'
alias p='python3 ~/dotfiles/scripts/projector/projector.py'
alias ga="git add ."
alias gc="git commit"
alias gp="git push -u origin master"
alias skim="open -a Skim"
alias vimrc="vim ~/dotfiles/nvim/init.vim"
alias tmuxrc="vim ~/dotfiles/tmux/tmux.conf"
alias zshrc="vim ~/dotfiles/zsh/zshrc.sh"
alias server="python2 -m SimpleHTTPServer 8000"
alias now="date +'%l:%M%p'"
alias hax="ssh root@159.65.247.247"
export LS_COLORS="di=1;35:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
alias oldtom="ssh -i ~/.ssh/oldtom h752@cs.dsunix.net"
alias tom="ssh -i ~/.ssh/newtom g803@cs.dsunix.net"
alias andrew="ssh -i ~/.ssh/andrew bailey.belisario@dev.hostbin.org"
alias gf="git add .; git commit; git push -u origin master"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


