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
alias server="python2 -m SimpleHTTPServer 80"
alias now="date +'%l:%M%p'"
export LS_COLORS="di=1;35:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
alias oldtom="ssh -i ~/.ssh/oldtom h752@cs.dsunix.net"
alias tom="ssh -i ~/.ssh/newtom g803@cs.dsunix.net"
alias andrew="ssh -i ~/.ssh/andrew bailey.belisario@dev.hostbin.org"
alias gf="git add .; git commit; git push -u origin master"
alias guac="ssh root@192.168.1.203 -i ~/.ssh/id_rsa"
alias prox="ssh root@192.168.1.100 -i ~/.ssh/proxmox"
alias kali="ssh root@192.168.1.187 -i ~/.ssh/kali"
alias hmi="ssh -p 2222 zonemix@zonemixhmi -i  ~/.ssh/scada"
alias plc="ssh -p 2222 zonemix@zonemixplc -i ~/.ssh/scada"
alias ubu="ssh -p 2223 zonemix@zonemixubunut -i ~/.ssh/id_rsa"
alias e="exit"
alias screensaver="/System/Library/CoreServices/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine"
alias skhdrc="vim ~/.config/skhd/skhdrc"
alias yabairc="vim ~/.config/yabai/yabairc"
alias zsrc="source ~/.zshrc"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export LS_COLORS="di=1;35:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
