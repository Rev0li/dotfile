# ~/.zshrc (via dotfiles symlink)

############################
# 📁 Variables d'environnement
############################
export DOTFILES_DIR="$HOME/dotfiles"
export MAIL="okientzl@student.42lyon.fr"

# Nettoyage du PATH
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

############################
# 💻 Apparence & Oh My Zsh
############################
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="eastwood"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

############################
# 🔌 Dotfiles personnalisés
############################
[ -f "$DOTFILES_DIR/zsh/brightness.sh" ] && source "$DOTFILES_DIR/zsh/brightness.sh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

############################
# 📁 Redirection XDG (optionnel)
############################
export XDG_CONFIG_HOME="$DOTFILES_DIR"

############################
# 🧠 Alias
############################
alias ll="ls -lah"
alias gs="git status"
alias gd="git diff"
alias ..="cd .."
alias src="source ~/.zshrc"
alias shortcuts="alias | sed -e 's/alias //g' | column -t -s '='"
alias shortcut="grep '^alias ' ~/.zshrc | sed -e 's/^alias //' | column -t -s '='"

# Logiciels portables
alias vi="$DOTFILES_DIR/nvim/nvim-linux64/bin/nvim"
alias kitty="$DOTFILES_DIR/kitty/kitty-linux64/bin/kitty --session ~/dotfiles/kitty/session.conf"

# Valgrind
alias vald="~/Documents/valgrind_breaker"
alias valfull='valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose'

############################
# ⚙️ Zsh Options
############################
setopt AUTO_CD
setopt HIST_FIND_NO_DUPS
bindkey -v

############################
# 💄 Oh My Posh (si installé)
############################
if command -v oh-my-posh &> /dev/null; then
  eval "$(oh-my-posh init zsh --config ~/dotfiles/OhMyPosh/hul10.omp.json)"
fi
# Remplacer la commande cd par une fonction personnalisée
cd() {
  builtin cd "$@" || return
  clear
  # Utilise tree si dispo, sinon ls -lh
  if command -v tree >/dev/null 2>&1; then
    tree -L 1 --dirsfirst -C
  else
    ls -lh --color=auto
  fi
}

