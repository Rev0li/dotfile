#!/usr/bin/env zsh
# Alias et raccourcis

# 📁 Navigation et fichiers
alias ll="ls -lah"
alias la="ls -la"
alias l="ls -l"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# 🔄 Git
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias glog="git log --oneline --graph --decorate"

# ⚙️ Système
alias src="source ~/.zshrc"
alias reload="source ~/.zshrc"
alias cls="clear"

# 📋 Utilitaires
alias shortcuts="alias | sed -e 's/alias //g' | column -t -s '='"
alias shortcut="grep '^alias ' ~/.zshrc | sed -e 's/^alias //' | column -t -s '='"

# 🧰 Logiciels portables
alias vi="$DOTFILES_DIR/nvim/nvim-linux64/bin/nvim"
alias nvim="$DOTFILES_DIR/nvim/nvim-linux64/bin/nvim"
alias kitty="$DOTFILES_DIR/kitty/kitty-linux64/bin/kitty --session ~/dotfiles/kitty/session.conf"

# 🔍 Développement
alias vald="~/Documents/valgrind_breaker"
alias valfull='valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose'

# 🎨 Styles d'affichage
alias style="set_display_style"
alias colors="set_colors"
alias preview="preview_styles"
alias header="set_display_style header"
alias minimal="set_display_style minimal"
alias stats="set_display_style stats"
alias fancy="set_display_style fancy"
alias bright="set_colors bright"
alias normal="set_colors normal"

# 🎯 Affichage
alias prompt_mode='clear && ls -lh'
alias tree1='tree -L 1 --dirsfirst -C'
alias tree2='tree -L 2 --dirsfirst -C'

# 🛠️ Édition rapide
alias edit="edit_zsh"
alias edit-aliases="edit_zsh aliases"
alias edit-functions="edit_zsh functions"
alias edit-styles="edit_zsh styles"
