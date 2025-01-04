# Zsh configuration
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="eastwood"  # Peut être modifié selon tes préférences

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias ll="ls -lah"
alias gs="git status"
alias gd="git diff"
alias ..="cd .."
alias nv="nvim"
alias src="source ~/.zshrc"
# Fuzzy finder (fzf) configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Export PATH
export PATH="$HOME/bin:$PATH"

# Options Zsh
setopt AUTO_CD       # Accès rapide aux dossiers
setopt HIST_FIND_NO_DUPS  # Pas de doublons dans l'historique
bindkey -v           # Mode vi

