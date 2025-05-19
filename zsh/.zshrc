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

# Détermine le chemin absolu du dossier contenant ce fichier .zshrc
export DOTFILES_DIR=$(cd "$(dirname "$(readlink -f "${(%):-%x}")")/.." && pwd)
export MAIL="okientzl@student.42lyon.fr"

# Aliases
alias ll="ls -lah"
alias gs="git status"
alias gd="git diff"
alias ..="cd .."
alias nv="$DOTFILES_DIR/nvim/nvim-linux64/bin/nvim"
alias src="source ~/.zshrc"
alias shortcuts="alias | sed -e 's/alias //g' | column -t -s '='"
alias shortcut="grep '^alias ' ~/.zshrc | sed -e 's/^alias //' | column -t -s '='"
alias vald="~/Documents/valgrind_breaker"
alias valfull="valgrind --leak-check=full --show-leak-kinds=definite "
# Fuzzy finder (fzf) configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Export PATH
export PATH="$HOME/bin:$PATH"

# Options Zsh
setopt AUTO_CD       # Accès rapide aux dossiers
setopt HIST_FIND_NO_DUPS  # Pas de doublons dans l'historique
bindkey -v           # Mode vi

export PATH="$HOME/.local/bin:$PATH"
