#!/usr/bin/env zsh
# Configuration Oh My Zsh et plugins

# 💻 Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="eastwood"
plugins=(
    git 
    zsh-autosuggestions 
    zsh-syntax-highlighting
)

# Charger Oh My Zsh
source $ZSH/oh-my-zsh.sh
