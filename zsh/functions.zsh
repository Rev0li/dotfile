#!/usr/bin/env zsh
# 🛠️ Fonctions utilitaires

# ═══════════════════════════════════════════════════════════
# 📁 Navigation
# ═══════════════════════════════════════════════════════════

# Créer et entrer dans un répertoire
mkcd() {
    if [[ -z "$1" ]]; then
        echo "Usage: mkcd <nom_du_repertoire>"
        return 1
    fi
    mkdir -p "$1" && cd "$1"
}

# Remonter de plusieurs niveaux
up() {
    local levels=${1:-1}
    local path=""
    
    for ((i=0; i<levels; i++)); do
        path="../$path"
    done
    
    cd "$path"
}

# Raccourcis pour remonter
..() { cd .. }
...() { cd ../.. }
....() { cd ../../.. }

# ═══════════════════════════════════════════════════════════
# 🔍 Recherche
# ═══════════════════════════════════════════════════════════

# Recherche rapide de fichiers
ff() {
    if [[ -z "$1" ]]; then
        echo "Usage: ff <motif_de_recherche>"
        return 1
    fi
    find . -type f -name "*$1*" 2>/dev/null
}

# Recherche de dossiers
fdd() {
    if [[ -z "$1" ]]; then
        echo "Usage: fdd <motif_de_recherche>"
        return 1
    fi
    find . -type d -name "*$1*" 2>/dev/null
}

# Recherche dans le contenu des fichiers
grep-files() {
    if [[ -z "$1" ]]; then
        echo "Usage: grep-files <motif> [extension]"
        return 1
    fi
    
    local pattern="$1"
    local extension="${2:-*}"
    
    grep -r --include="*.$extension" "$pattern" . 2>/dev/null
}

# ═══════════════════════════════════════════════════════════
# 📦 Gestion des archives
# ═══════════════════════════════════════════════════════════

# Extraire différents types d'archives
extract() {
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
        *)           echo "Format non supporté: '$1'" ;;
    esac
}

# Créer une archive
archive() {
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

# ═══════════════════════════════════════════════════════════
# 💻 Système et informations
# ═══════════════════════════════════════════════════════════

# Informations système rapides
sysinfo() {
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
dirsize() {
    local target="${1:-.}"
    echo "📊 Taille des dossiers dans: $target"
    echo "─────────────────────────────────"
    du -sh "$target"/* 2>/dev/null | sort -hr
}

# Processus utilisant le plus de CPU/RAM
topproc() {
    echo "🚀 Processus les plus gourmands:"
    echo "─────────────────────────────────"
    ps aux --sort=-%cpu | head -11
}

# ═══════════════════════════════════════════════════════════
# 🌐 Réseau
# ═══════════════════════════════════════════════════════════

# Ping rapide
myping() {
    local host="${1:-google.com}"
    ping -c 4 "$host"
}

# Ports ouverts
open-ports() {
    echo "🔌 Ports en écoute:"
    echo "─────────────────"
    netstat -tuln 2>/dev/null || ss -tuln
}
