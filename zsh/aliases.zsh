#!/usr/bin/env zsh
# Alias et raccourcis

# ─────────────────────────────────────────────
# 📁 Navigation et fichiers
# ─────────────────────────────────────────────
alias ll="ls -lah"
alias la="ls -la"
alias l="ls -l"

# Note: .. ... .... sont des fonctions dans functions.zsh (pas des alias)
# pour que la fonction cd() personnalisée se déclenche

# Alias modernes (si installés)
if command -v eza &> /dev/null; then
    alias ls="eza --icons"
    alias ll="eza -lah --icons"
    alias la="eza -la --icons"
    alias tree="eza --tree --icons"
fi

if command -v bat &> /dev/null; then
    alias cat="bat --style=plain"
    alias ccat="bat"  # cat avec coloration
fi

# ─────────────────────────────────────────────
# 🔄 Git
# ─────────────────────────────────────────────
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit"
alias gcm="git commit -m"
alias gp="git push"
alias gl="git pull"
alias glog="git log --oneline --graph --decorate"
alias gco="git checkout"
alias gb="git branch"
alias gba="git branch -a"

# ─────────────────────────────────────────────
# ⚙️ Système
# ─────────────────────────────────────────────
alias src="source ~/.zshrc"
alias reload="source ~/.zshrc"
alias cls="clear"
alias c="clear"

# Raccourcis système
alias h="history"
alias j="jobs"
alias ports="netstat -tuln"
alias myip="curl -s ifconfig.me"

# ─────────────────────────────────────────────
# 🧰 Logiciels portables
# ─────────────────────────────────────────────
alias vi="$DOTFILES_DIR/nvim/nvim-linux64/bin/nvim"
alias nvim="$DOTFILES_DIR/nvim/nvim-linux64/bin/nvim"
alias vim="nvim"

# Kitty (sans session car supprimée)
if [ -f "$DOTFILES_DIR/kitty/kitty-linux64/bin/kitty" ]; then
    alias kitty="$DOTFILES_DIR/kitty/kitty-linux64/bin/kitty"
fi

# ─────────────────────────────────────────────
# 🔍 Développement
# ─────────────────────────────────────────────
# Valgrind
alias vald="~/Documents/valgrind_breaker"
alias valfull='valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose'
alias valfd='valgrind --leak-check=full --show-leak-kinds=all --track-fds=yes'

# Compilation C
alias gcc-debug='gcc -Wall -Wextra -Werror -g'
alias gcc-strict='gcc -Wall -Wextra -Werror -pedantic'

# Make
alias mk="make"
alias mkc="make clean"
alias mkf="make fclean"
alias mkr="make re"

# ─────────────────────────────────────────────
# 🎯 Affichage et navigation
# ─────────────────────────────────────────────
alias tree1='tree -L 1 --dirsfirst -C'
alias tree2='tree -L 2 --dirsfirst -C'
alias tree3='tree -L 3 --dirsfirst -C'

# Luminosité (fonction brightness.sh)
alias bright="lumos"
alias br="lumos"

# ─────────────────────────────────────────────
# 🛠️ Édition rapide
# ─────────────────────────────────────────────
alias edit="edit_zsh"
alias edit-aliases="edit_zsh aliases"
alias edit-functions="edit_zsh functions"
alias edit-styles="edit_zsh styles"
alias edit-zsh="edit_zsh"

# Édition rapide de fichiers courants
alias zshrc="$EDITOR ~/.zshrc"
alias vimrc="$EDITOR ~/.config/nvim/init.lua"
alias kittyconf="$EDITOR ~/dotfiles/kitty/kitty.conf"

# ─────────────────────────────────────────────
# 📋 Utilitaires
# ─────────────────────────────────────────────
alias shortcuts="alias | sed -e 's/alias //g' | column -t -s '='"

# Copier dans le presse-papier (si xclip installé)
if command -v xclip &> /dev/null; then
    alias clip="xclip -selection clipboard"
    alias paste="xclip -selection clipboard -o"
fi

# ─────────────────────────────────────────────
# 🚀 Raccourcis pratiques
# ─────────────────────────────────────────────
# Créer et entrer dans un dossier
alias mkd="mkcd"

# Recherche rapide
alias f="ff"
alias g="grep_files"

# Taille des dossiers
alias du1="du -h --max-depth=1 | sort -hr"
alias du2="du -h --max-depth=2 | sort -hr"

# Processus
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias top="htop"

# ─────────────────────────────────────────────
# 🎨 Dotfiles
# ─────────────────────────────────────────────
alias dots="cd ~/dotfiles"
alias dotfiles="cd ~/dotfiles"
