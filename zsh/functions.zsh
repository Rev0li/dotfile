#!/usr/bin/env zsh
# 🛠️ Fonctions utilitaires

############################
# 📁 Navigation
############################

# Fonction cd personnalisée avec affichage stylisé
cd() {
    builtin cd "$@" || return
    display_centered
}

# Créer et aller dans un répertoire
function mkcd() {
    if [[ -z "$1" ]]; then
        echo "Usage: mkcd <nom_du_repertoire>"
        return 1
    fi
    mkdir -p "$1" && cd "$1"
}

# Remonter de plusieurs niveaux
function up() {
    local levels=${1:-1}
    local path=""
    
    for ((i=0; i<levels; i++)); do
        path="../$path"
    done
    
    cd "$path"
}

############################
# 🔍 Recherche
############################

# Recherche rapide de fichiers
function ff() {
    if [[ -z "$1" ]]; then
        echo "Usage: ff <motif_de_recherche>"
        return 1
    fi
    find . -type f -name "*$1*" 2>/dev/null
}

# Recherche de dossiers
function fd() {
    if [[ -z "$1" ]]; then
        echo "Usage: fd <motif_de_recherche>"
        return 1
    fi
    find . -type d -name "*$1*" 2>/dev/null
}

# Recherche dans le contenu des fichiers
function grep_files() {
    if [[ -z "$1" ]]; then
        echo "Usage: grep_files <motif> [extension]"
        return 1
    fi
    
    local pattern="$1"
    local extension="${2:-*}"
    
    grep -r --include="*.$extension" "$pattern" . 2>/dev/null
}

############################
# 📦 Gestion des archives
############################

# Extraire différents types d'archives
function extract() {
    if [[ -z "$1" ]]; then
        echo "Usage: extract <fichier_archive>"
        return 1
    fi
    
    if [[ ! -f "$1" ]]; then
        echo "Erreur: '$1' n'est pas un fichier valide"
        return 1
    fi
    
    case "$1" in
        *.tar.bz2)   tar xjf "$1"     ;;
        *.tar.gz)    tar xzf "$1"     ;;
        *.tar.xz)    tar xJf "$1"     ;;
        *.bz2)       bunzip2 "$1"     ;;
        *.rar)       unrar x "$1"     ;;
        *.gz)        gunzip "$1"      ;;
        *.tar)       tar xf "$1"      ;;
        *.tbz2)      tar xjf "$1"     ;;
        *.tgz)       tar xzf "$1"     ;;
        *.zip)       unzip "$1"       ;;
        *.Z)         uncompress "$1"  ;;
        *.7z)        7z x "$1"        ;;
        *.deb)       ar x "$1"        ;;
        *.tar.lz)    tar xf "$1"      ;;
        *.lz)        lzip -d "$1"     ;;
        *)           echo "Format non supporté: '$1'" ;;
    esac
}

# Créer une archive
function archive() {
    if [[ $# -lt 2 ]]; then
        echo "Usage: archive <nom_archive.ext> <fichiers/dossiers...>"
        echo "Extensions supportées: .tar.gz, .tar.bz2, .tar.xz, .zip"
        return 1
    fi
    
    local archive_name="$1"
    shift
    
    case "$archive_name" in
        *.tar.gz)   tar czf "$archive_name" "$@" ;;
        *.tar.bz2)  tar cjf "$archive_name" "$@" ;;
        *.tar.xz)   tar cJf "$archive_name" "$@" ;;
        *.zip)      zip -r "$archive_name" "$@" ;;
        *)          echo "Format non supporté: '$archive_name'" ;;
    esac
}

############################
# 💻 Système et informations
############################

# Informations système rapides
function sysinfo() {
    echo "🖥️  Informations système:"
    echo "─────────────────────────"
    echo "OS: $(uname -s)"
    echo "Kernel: $(uname -r)"
    echo "Architecture: $(uname -m)"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p 2>/dev/null || uptime)"
    echo "Shell: $SHELL"
    echo "Terminal: $TERM"
}

# Taille des dossiers
function dirsize() {
    local target="${1:-.}"
    echo "📊 Taille des dossiers dans: $target"
    echo "─────────────────────────────────"
    du -sh "$target"/* 2>/dev/null | sort -hr
}

# Processus utilisant le plus de CPU/RAM
function topproc() {
    echo "🚀 Processus les plus gourmands:"
    echo "─────────────────────────────────"
    ps aux --sort=-%cpu | head -11
}

############################
# 🌐 Réseau
############################

# Ping rapide
function myping() {
    local host="${1:-google.com}"
    ping -c 4 "$host"
}

# Ports ouverts
function ports() {
    echo "🔌 Ports en écoute:"
    echo "─────────────────"
    netstat -tuln 2>/dev/null || ss -tuln
}

############################
# 🔧 Utilitaires divers
############################

# Calculatrice rapide
function calc() {
    if command -v bc >/dev/null 2>&1; then
        echo "$*" | bc -l
    else
        echo "bc n'est pas installé"
    fi
}

# Générer un mot de passe
function genpass() {
    local length="${1:-16}"
    if command -v openssl >/dev/null 2>&1; then
        openssl rand -base64 32 | tr -d "=+/" | cut -c1-"$length"
    else
        head /dev/urandom | tr -dc A-Za-z0-9 | head -c "$length"
        echo
    fi
}

# Météo (nécessite curl)
function weather() {
    local city="${1:-Paris}"
    if command -v curl >/dev/null 2>&1; then
        curl -s "wttr.in/$city?format=3"
    else
        echo "curl n'est pas installé"
    fi
}

############################
# 📝 Édition rapide
############################

# Éditer rapidement les fichiers de config zsh
function edit_zsh() {
    case "$1" in
        "rc"|"")        $EDITOR ~/.zshrc ;;
        "aliases")      $EDITOR "$ZSH_CONFIG_DIR/aliases.zsh" ;;
        "functions")    $EDITOR "$ZSH_CONFIG_DIR/functions.zsh" ;;
        "exports")      $EDITOR "$ZSH_CONFIG_DIR/exports.zsh" ;;
        "styles")       $EDITOR "$ZSH_CONFIG_DIR/styles.zsh" ;;
        "plugins")      $EDITOR "$ZSH_CONFIG_DIR/plugins.zsh" ;;
        "local")        $EDITOR "$ZSH_CONFIG_DIR/local.zsh" ;;
        *)              echo "Fichiers disponibles: rc, aliases, functions, exports, styles, plugins, local" ;;
    esac
}

############################
# 🎯 Alias de fonctions
############################

# Alias courts pour les fonctions les plus utilisées
alias ..2='up 2'
alias ..3='up 3'
alias ..4='up 4'
alias search='grep_files'
alias info='sysinfo'
alias size='dirsize'
alias top='topproc'
