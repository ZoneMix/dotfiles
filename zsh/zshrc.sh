export ZSH=~/.dotfiles/zsh
plugins=(git)
# source $ZSH/prompt.sh
source $ZSH/plugins/auto-ls/auto-ls.sh
# source $ZSH/plugins/git/git.sh
source $ZSH/plugins/vi-mode/vi-mode.sh
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

source $ZSH/oh-my-zsh.sh

PROMPT='[%F{39}%~%F{reset}$(git_prompt_info)%(?::, %F{red}%?%F{reset})]: '

ZSH_THEME_GIT_PROMPT_PREFIX=", %F{21}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{reset}"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{reset} %F{226}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{reset}"
