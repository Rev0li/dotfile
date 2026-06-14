---
type: audit-forme
scope: dotfiles
date: 2026-06-14
readiness: { navigation: ⚠️, fragmentation: ✅ }
---

# Audit forme — dotfiles — 2026-06-14

> Audit de **forme** (navigabilité + fragmentation), diagnostic seul, via le skill
> `audit-structure`. Complémentaire de l'`AUDIT.md` du 2026-06-10 (sécurité / hygiène
> git / bugs runtime) qui reste valable : ici on ne regarde que « est-ce facile à
> naviguer et à modifier ? ». La section « Documentation désynchronisée » de l'ancien
> audit est reprise, revérifiée (4 jours après) et enrichie de findings neufs.

## Synthèse

Projet petit et **très bien fragmenté** : le découpage zsh modulaire, les scripts
isolés et l'absence de fichier > 333 lignes rendent toute retouche locale facile —
réflexe 42 respecté. Le point faible est la **navigation par la doc** : `README.md`
et `CLAUDE.md` décrivent *tous les deux* l'architecture (structure, ordre de
chargement, binaires, raccourcis), donc divergent — et divergent déjà sur ~8 points.
Une IA fraîche qui fait confiance à la doc cherchera des fichiers fantômes
(`plugins.zsh`, `languages.toml`) et des comportements inexistants (3 panes
auto WezTerm). Rien de bloquant, mais la doc trahit le code.

| Axe | Note | En une phrase |
|---|---|---|
| Navigabilité & doc (IA) | ⚠️ | Doc riche mais désynchronisée sur ~8 points ; double source de vérité README ↔ CLAUDE. |
| Fragmentation (humain)  | ✅ | Découpage exemplaire pour la taille ; un seul gros fichier (`install.sh`) assumé. |

## Axe A — Navigabilité & doc

### Doc ↔ code (le cœur — écarts qui trompent une IA)

- **`zsh/plugins.zsh` fantôme.** Annoncé dans l'ordre de chargement par
  `CLAUDE.md:31`, `README.md:56`, *et* le `~/CLAUDE.md` racine. Le fichier n'existe
  pas et `zsh/custom_zshrc.zsh:14-18` ne le source pas (ordre réel : `exports →
  styles → options → aliases → functions`). Aucune trace d'Oh My Zsh non plus.
  *(déjà signalé le 2026-06-10, toujours vrai)*
- **`helix/languages.toml` fantôme.** Listé dans la structure `README.md:42`
  (« Surcharges LSP par langage ») — `helix/` ne contient que `config.toml`. *(neuf)*
- **Layout WezTerm « 3 panes au gui-startup » fantôme.** `CLAUDE.md:39-40` décrit
  un auto-maximize + création de 3 panes au démarrage. `wezterm/wezterm.lua` n'a
  **aucun** handler `gui-startup`. *(déjà signalé, confirmé)*
- **`mdcat` et `clangd` décrits comme binaires installés/symlinkés** (`CLAUDE.md:28`).
  `install.sh` ne gère que `starship`, `hx`, `eza`, `wezterm`
  (`do_install_*` l.102-164). *(déjà signalé, confirmé)*
- **README omet `eza`.** `README.md:28` liste « starship, hx, wezterm » alors
  qu'`install.sh:132` installe aussi `eza`. *(neuf)*
- **2 scripts sur 6 non documentés.** `script/shortcut.sh` et `script/wezterm-help.sh`
  n'apparaissent dans aucun `.md` (ni README structure, ni CLAUDE commands). *(neuf)*
- **Alias git fantômes.** `README.md:103` annonce `gcb` et `gst` — absents de
  `zsh/aliases.zsh` (qui s'arrête à `gb`). *(neuf)*
- **Raccourcis WezTerm `ALT+c` / `ALT+v` inversés.** `README.md:78-79` et
  `CLAUDE.md:40` disent c = horizontal / v = vertical ; `wezterm.lua:74-75` fait
  l'inverse (`ALT+c` = SplitVertical, `ALT+v` = SplitHorizontal). *(neuf)*

### Sommaire, plan d'archi, liens

- **Cause racine : double source de vérité.** `README.md` (humain) et `CLAUDE.md`
  (IA) décrivent la **même** architecture en parallèle. Toute évolution du code doit
  être répercutée à deux endroits → en pratique elle ne l'est qu'à zéro. C'est ce qui
  produit tous les écarts ci-dessus.
- **Pas d'index/sommaire des docs.** 4 fichiers `.md` à la racine (`README`, `CLAUDE`,
  `install.md`, `AUDIT.md`) sans table d'entrée. Acceptable à cette taille, mais aucun
  point d'orientation centralisé et les `.md` ne se lient pas entre eux.
- **Liens internes : OK.** Peu de liens Markdown, aucun cassé détecté.
- **Plan d'archi présent et globalement bon** (`CLAUDE.md` « Architecture », tableau
  des symlinks, système de thème) — c'est le *contenu* qui a vieilli, pas la forme.

## Axe B — Fragmentation & modularité

- **Découpage zsh exemplaire.** 6 modules à responsabilité nette
  (`exports`/`styles`/`options`/`aliases`/`functions` + loader `custom_zshrc`),
  chacun < 65 lignes. On devine le rôle au nom. Rien à redécouper.
- **`install.sh` (332 l.) = seul gros fichier**, multi-responsabilités (check deps,
  symlinks, download par outil, police). Cohérent et lisible, mais c'est le candidat
  naturel à une extraction : `latest_release`/`installed_version`/`normalize` sont
  dupliquées avec `script/check-versions.sh` → une `script/lib.sh` partagée
  éviterait la divergence. *(rejoint l'AUDIT.md)*
- **`zsh/styles.zsh` quasi vide (3 l.)** : à la limite de l'inutile, mais cohérent
  avec le découpage et sans coût. Pas un problème.
- **Bruit de navigation : `chpwd()` défini 2×** (`zsh/options.zsh:29` et
  `zsh/functions.zsh:23`) — la 2e gagne, la 1re est du code mort. *(déjà signalé)*

## Plan d'amélioration

### P1 — à faire d'abord
- **Constat** : double source de vérité README ↔ CLAUDE → désync chronique.
  **Gêne** : les deux (IA suit une doc fausse ; humain maintient deux fois).
  **Action** : désigner une seule source d'archi. Reco : `CLAUDE.md` garde
  l'architecture détaillée (pour l'IA), `README.md` se limite à l'usage + un lien
  « architecture → voir CLAUDE.md ». Ne plus dupliquer structure/load-order/raccourcis.
  **Effort** : M
- **Constat** : fichiers/comportements fantômes (`plugins.zsh`, `languages.toml`,
  3-panes WezTerm, `mdcat`/`clangd`).
  **Gêne** : IA surtout (cherche ce qui n'existe pas).
  **Action** : supprimer ces mentions de `README.md`, `CLAUDE.md` *et* `~/CLAUDE.md`
  racine (qui répète le load-order faux).
  **Effort** : S

### P2 — ensuite
- **Constat** : petits écarts doc↔code (eza absent du README, `shortcut.sh` /
  `wezterm-help.sh` non documentés, alias `gcb`/`gst` fantômes, `ALT+c`/`v` inversés).
  **Gêne** : les deux (friction, copie d'alias qui échoue).
  **Action** : aligner README/CLAUDE sur le réel une fois la source unique choisie.
  **Effort** : S
- **Constat** : pas d'index des docs (désormais 5 avec ce rapport).
  **Gêne** : IA/humain à mesure que `docs/` grossit.
  **Action** : un court sommaire en tête de `README.md` listant `docs/`.
  **Effort** : S

### P3 — confort
- **Constat** : `chpwd()` dupliqué (code mort dans `options.zsh`).
  **Gêne** : humain (bruit).
  **Action** : retirer la définition d'`options.zsh`. **Effort** : S
- **Constat** : helpers dupliqués `install.sh` ↔ `check-versions.sh`.
  **Gêne** : humain (divergence latente). **Action** : extraire `script/lib.sh`.
  **Effort** : M

## Pour la suite

- **P1 → un ticket** « source de vérité unique + purge des fantômes » : c'est le
  geste à plus fort levier, il referme ~6 des 8 écarts d'un coup.
- **P2 → un ticket** d'alignement fin, à faire juste après P1 (sinon on réaligne sur
  une doc encore dupliquée).
- **P3** : reprendre tel quel depuis l'`AUDIT.md` du 2026-06-10 (déjà décrit là-bas).
- Les findings **sécurité / hygiène git / bugs runtime** de l'`AUDIT.md` (discord/,
  `.git` 99 Mo, `bin/eza` tracké, `STARSHIP_CONFIG` sans effet…) sont **hors périmètre**
  de cet audit de forme mais restent à traiter — ne pas les perdre.
