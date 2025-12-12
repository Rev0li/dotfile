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
alias ga="git add ."
alias gc="git clone"

# ─────────────────────────────────────────────
# ⚙️ Système
# ─────────────────────────────────────────────
alias src="source ~/.zshrc"
alias c="clear"

# Raccourcis système
alias h="history"
alias j="jobs"
alias ports="netstat -tuln"
alias myip="curl -s ifconfig.me"

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
