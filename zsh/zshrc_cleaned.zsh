# ~/.zshrc — Configuration propre et modulaire
############################
# 📁 Dotfiles & Environnement
############################
export DOTFILES_DIR="$HOME/dotfiles"  # Modifie si nécessaire
export MAIL="okientzl@student.42lyon.fr"
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

############################
# 🎨 Apparence & Thème
############################
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="eastwood"  # Choisis ton thème préféré (ex: robbyrussell, agnoster, etc.)

############################
# 🔌 Plugins Oh My Zsh
############################
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh
source $DOTFILES_DIR/zsh/brightness.sh



# Rediriger les configs XDG vers les dotfiles
export XDG_CONFIG_HOME="$DOTFILES_DIR"

############################
# 🧠 Alias pratiques
############################
alias ll="ls -lah"
alias gs="git status"
alias gd="git diff"
alias ..="cd .."
alias src="source ~/.zshrc"
alias shortcuts="alias | sed -e 's/alias //g' | column -t -s '='"
alias shortcut="grep '^alias ' ~/.zshrc | sed -e 's/^alias //' | column -t -s '='"

# Software local en version portable
alias vi="$DOTFILES_DIR/nvim/nvim-linux64/bin/nvim"
alias kitty="$DOTFILES_DIR/kitty/kitty-linux64/bin/kitty --session ~/dotfiles/kitty/session.conf"

# Valgrind perso
alias vald="~/Documents/valgrind_breaker"
alias valfull='valgrind \
  --leak-check=full \
  --show-leak-kinds=all \
  --track-origins=yes \
  --verbose

############################
# 🔍 Outils externes
############################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

############################
# ⚙️ Options Zsh
############################
setopt AUTO_CD             # cd automatique sans taper 'cd'
setopt HIST_FIND_NO_DUPS   # pas de doublons dans l'historique
bindkey -v                 # mode vi (ESC = normal mode)

############################
# 🧪 Débug Neovim (alias nvdebug)
############################
alias nvdebug='nv --headless "+lua print(vim.fn.stdpath(\"config\"))" +q && nv --headless "+lua print(vim.fn.stdpath(\"data\"))" +q && nv --version'

ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"

# ln -sf ~/dotfiles/zsh/zshrc_cleaned.zsh ~/.zshrc
eval "$(oh-my-posh init zsh --config ~/dotfiles/OhMyPosh/hul10.omp.json)"

