export ZSH=~/dotfiles/zsh
plugins=(git)
# source $ZSH/prompt.sh
source $ZSH/plugins/auto-ls/auto-ls.sh
# source $ZSH/plugins/git/git.sh
source $ZSH/plugins/vi-mode/vi-mode.sh
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

source $ZSH/oh-my-zsh.sh

function git_files(){
	if git rev-parse --git-dir > /dev/null 2>&1; then
		files=$(git status -s | wc -l | awk '{$1=$1};1')
		if [[ files -ne "0" ]]; then
			echo "%F{142}+$files%F{reset}"
		fi
		echo ''
	else
		echo ''
	fi
}

PROMPT='[%F{75}%~%F{reset}$(git_prompt_info)$(git_files)%(?::, %F{209}%?%F{reset})]: '

ZSH_THEME_GIT_PROMPT_PREFIX=", %F{98}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{reset}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
