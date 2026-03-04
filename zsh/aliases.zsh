#!/usr/bin/env zsh
# Alias et raccourcis

# ═══════════════════════════════════════════════════════════
# 📁 Navigation et fichiers
# ═══════════════════════════════════════════════════════════

alias ll="ls -lah"
alias la="ls -la"
alias l="ls -l"

# Alias modernes (si installés)
if command -v eza &> /dev/null; then
    alias ls="eza --icons"
    alias ll="eza -lah --icons"
    alias la="eza -la --icons"
    alias tree="eza --tree --icons"
fi

if command -v bat &> /dev/null; then
    alias cat="bat --style=plain"
    alias ccat="bat"  # cat avec coloration syntaxique
fi

# ═══════════════════════════════════════════════════════════
# 🔄 Git
# ═══════════════════════════════════════════════════════════

alias gs="git status"
alias gd="git diff"
alias ga="git add ."
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"
alias gco="git checkout"
alias gb="git branch"

# ═══════════════════════════════════════════════════════════
# ⚙️ Système
# ═══════════════════════════════════════════════════════════

alias c="clear"
alias h="history"
alias src="source ~/.zshrc"
alias reload="exec zsh"

# Informations système
alias ports="netstat -tuln"
alias myip="curl -s ifconfig.me"

# ═══════════════════════════════════════════════════════════
# 🎯 Dotfiles
# ═══════════════════════════════════════════════════════════

alias dots="cd ~/dotfiles"
alias dotfiles="cd ~/dotfiles"
alias check-versions="$DOTFILES_DIR/bin/check-versions.sh"

# Édition rapide des configs
alias helix-conf="hx ~/dotfiles/helix/config.toml"
alias starship-conf="hx ~/dotfiles/starship/starship.toml"
alias wezterm-conf="hx ~/dotfiles/wezterm/wezterm.lua"
alias zsh-conf="hx ~/.zshrc"

# ═══════════════════════════════════════════════════════════
# 🎨 Thème dark / light
# ═══════════════════════════════════════════════════════════

alias dark="$DOTFILES_DIR/theme-toggle.sh dark"
alias light="$DOTFILES_DIR/theme-toggle.sh light"
alias theme="$DOTFILES_DIR/theme-toggle.sh"

# ═══════════════════════════════════════════════════════════
# 🔍 Recherche
# ═══════════════════════════════════════════════════════════

alias f="find . -type f -name"
alias fd="find . -type d -name"

# Ripgrep (si installé)
if command -v rg &> /dev/null; then
    alias grep="rg"
fi
