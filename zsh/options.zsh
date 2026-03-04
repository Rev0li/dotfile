#!/usr/bin/env zsh
# Options et comportements Zsh

# ═══════════════════════════════════════════════════════════
# 📁 Navigation
# ═══════════════════════════════════════════════════════════

setopt AUTO_CD                    # cd automatique sans taper "cd"
setopt AUTO_PUSHD                 # push automatique dans la pile de dirs
setopt PUSHD_IGNORE_DUPS          # ignorer les doublons dans la pile
setopt CDABLE_VARS                # cd vers les variables

# ═══════════════════════════════════════════════════════════
# 📜 Historique
# ═══════════════════════════════════════════════════════════

setopt HIST_FIND_NO_DUPS          # pas de doublons dans la recherche
setopt HIST_IGNORE_ALL_DUPS       # ignorer tous les doublons
setopt HIST_IGNORE_SPACE          # ignorer les commandes avec espace initial
setopt HIST_SAVE_NO_DUPS          # pas de doublons en sauvegarde
setopt SHARE_HISTORY              # partager l'historique entre sessions
setopt EXTENDED_HISTORY           # horodatage dans l'historique

# ═══════════════════════════════════════════════════════════
# ⌨️ Mode édition
# ═══════════════════════════════════════════════════════════

bindkey -v                        # Mode vi/vim

# ═══════════════════════════════════════════════════════════
# 🎯 Complétion
# ═══════════════════════════════════════════════════════════

setopt AUTO_MENU                  # menu automatique pour la complétion
setopt COMPLETE_IN_WORD           # complétion au milieu des mots
setopt ALWAYS_TO_END              # curseur à la fin après complétion
setopt MENU_COMPLETE              # insérer la première complétion immédiatement

# ═══════════════════════════════════════════════════════════
# 🔔 Comportement
# ═══════════════════════════════════════════════════════════

setopt NO_BEEP                    # désactiver les bips
setopt CORRECT                    # correction des commandes
