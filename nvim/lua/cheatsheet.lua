-- ════════════════════════════════════════
-- 📚 Cheatsheet Neovim - Fenêtre centrée
-- ════════════════════════════════════════

local M = {}

-- Contenu du cheatsheet
local cheatsheet_content = [[
╔══════════════════════════════════════════════════════════════════════════════╗
║                     📚 CHEATSHEET NEOVIM - Raccourcis essentiels            ║
╚══════════════════════════════════════════════════════════════════════════════╝

┌─ 🔖 MARKS (Marques) ─────────────────────────────────────────────────────────┐
│ ma          Créer mark 'a' (local au fichier)                                │
│ mA          Créer mark 'A' (global, tous fichiers)                           │
│ 'a          Aller au mark 'a' (début de ligne)                               │
│ `a          Aller au mark 'a' (position exacte)                              │
│ :marks      Voir tous les marks                                              │
│ :delmarks a Supprimer mark 'a'                                               │
│ `.          Aller à la dernière modification                                 │
│ `^          Aller à la dernière insertion                                    │
│ `[          Début du dernier changement/yank                                 │
│ `]          Fin du dernier changement/yank                                   │
└──────────────────────────────────────────────────────────────────────────────┘

┌─ ✂️ TEXT OBJECTS (ci/ca/di/da/vi/va) ───────────────────────────────────────┐

│ ci{         Change Inside {}        │ ca{  Change Around {} (inclut {})     │
│ ci"         Change Inside ""        │ ca"  Change Around "" (inclut "")     │
│ ci'         Change Inside ''        │ ca'  Change Around '' (inclut '')     │
│ ci[         Change Inside []        │ ca[  Change Around [] (inclut [])     │
│ cit         Change Inside Tag       │ cat  Change Around Tag                │
│ ciw         Change Inside Word      │ caw  Change Around Word               │
│                                     │                                        │
│ di(         Delete Inside ()        │ da(  Delete Around ()                 │
│ vi(         Visual Inside ()        │ va(  Visual Around ()                 │
│ yi(         Yank Inside ()          │ ya(  Yank Around ()                   │
│                                     │                                        │
│ ✅ ASTUCE : Tu as 1 seconde pour taper ci' ou ci" (timeout = 1s)            │
└──────────────────────────────────────────────────────────────────────────────┘

┌─ 🚀 NAVIGATION ──────────────────────────────────────────────────────────────┐
│ gg          Début du fichier        │ G    Fin du fichier                   │
│ {           Paragraphe précédent    │ }    Paragraphe suivant               │
│ %           Aller au () {} [] correspondant                                  │
│ *           Chercher mot sous curseur (suivant)                              │
│ #           Chercher mot sous curseur (précédent)                            │
│ f<char>     Aller à <char> sur la ligne                                      │
│ F<char>     Aller à <char> (arrière)                                         │
│ t<char>     Aller avant <char>                                               │
│ T<char>     Aller avant <char> (arrière)                                     │
│ ;           Répéter f/F/t/T                                                  │
│ ,           Répéter f/F/t/T (inverse)                                        │
│ Ctrl-o      Position précédente                                              │
│ Ctrl-i      Position suivante                                                │
└──────────────────────────────────────────────────────────────────────────────┘

┌─ 👁️ VISUAL MODE ────────────────────────────────────────────────────────────┐
│ v           Visual mode (caractères)                                         │
│ V           Visual Line (lignes)                                             │
│ Ctrl-v      Visual Block (bloc)                                              │
│ o           Changer de côté de sélection                                     │
│ gv          Re-sélectionner dernière sélection                               │
│ >           Indenter (en visual)                                             │
│ <           Dé-indenter (en visual)                                          │
└──────────────────────────────────────────────────────────────────────────────┘

┌─ 🔍 SEARCH & REPLACE ────────────────────────────────────────────────────────┐
│ /pattern    Chercher                │ n    Résultat suivant                 │
│ ?pattern    Chercher (arrière)      │ N    Résultat précédent               │
│ :%s/old/new/g       Remplacer tout                                           │
│ :%s/old/new/gc      Remplacer (avec confirmation)                            │
│ :noh                Enlever highlight                                        │
│ * puis cgn          Change next occurrence                                   │
│ .                   Répéter dernière commande                                │
└──────────────────────────────────────────────────────────────────────────────┘

┌─ 📝 WINDOWS & BUFFERS ───────────────────────────────────────────────────────┐
│ Ctrl-w s    Split horizontal        │ Ctrl-w v  Split vertical              │
│ Ctrl-w h/j/k/l  Naviguer entre splits                                        │
│ Ctrl-w =    Égaliser taille splits                                           │
│ Ctrl-w _    Maximiser hauteur       │ Ctrl-w |  Maximiser largeur           │
│ Ctrl-w q    Fermer split                                                     │
│ :bn         Buffer suivant          │ :bp       Buffer précédent            │
│ :bd         Fermer buffer                                                    │
└──────────────────────────────────────────────────────────────────────────────┘

┌─ ↩️ UNDO/REDO ───────────────────────────────────────────────────────────────┐
│ u           Undo                    │ Ctrl-r    Redo                        │
│ U           Undo ligne entière                                               │
│ :earlier 5m Revenir 5 min en arrière                                         │
│ :later 5m   Avancer 5 min                                                    │
└──────────────────────────────────────────────────────────────────────────────┘

┌─ 🔄 REGISTERS ───────────────────────────────────────────────────────────────┐
│ "ay         Yank dans register a    │ "ap       Paste depuis register a     │
│ "+y         Yank vers clipboard système                                      │
│ "+p         Paste depuis clipboard système                                   │
│ :reg        Voir tous les registers                                          │
│ "0p         Paste dernier yank (pas delete)                                  │
└──────────────────────────────────────────────────────────────────────────────┘

┌─ 📁 FILES ───────────────────────────────────────────────────────────────────┐
│ :e file     Ouvrir fichier          │ :w        Sauvegarder                 │
│ :wq         Sauvegarder et quitter  │ :q!       Quitter sans sauver         │
│ :wa         Sauvegarder tous        │ :qa       Quitter tous                │
└──────────────────────────────────────────────────────────────────────────────┘

┌─ 🔍 TELESCOPE (Recherche) ───────────────────────────────────────────────────┐
│ <leader>f   Trouver fichiers par nom                                         │
│ <leader>g   Rechercher texte dans tous les fichiers (live grep)             │
│ <leader>b   Lister les buffers ouverts                                      │
│                                                                               │
│ Dans Telescope :                                                             │
│   Ctrl-n/p  Naviguer haut/bas       │ Enter     Ouvrir fichier              │
│   Esc       Fermer Telescope        │ Ctrl-c    Annuler                     │
└──────────────────────────────────────────────────────────────────────────────┘

                    Appuie sur 'q' ou <Esc> pour fermer
]]

-- Créer et afficher la fenêtre flottante
function M.show()
  -- Créer un buffer scratch
  local buf = vim.api.nvim_create_buf(false, true)
  
  -- Diviser le contenu en lignes
  local lines = vim.split(cheatsheet_content, '\n')
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  
  -- Options du buffer (nouvelle API)
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].filetype = 'cheatsheet'
  vim.bo[buf].modifiable = false
  
  -- Calculer la taille de la fenêtre
  local width = 80
  local height = math.min(#lines, vim.o.lines - 4)
  
  -- Calculer la position centrée
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  
  -- Options de la fenêtre flottante
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = ' 📚 Cheatsheet Neovim ',
    title_pos = 'center',
  }
  
  -- Créer la fenêtre flottante
  local win = vim.api.nvim_open_win(buf, true, opts)
  
  -- Keymaps pour fermer
  local close_keys = { 'q', '<Esc>', '<CR>' }
  for _, key in ipairs(close_keys) do
    vim.api.nvim_buf_set_keymap(buf, 'n', key, ':close<CR>', {
      nowait = true,
      noremap = true,
      silent = true
    })
  end
  
  -- Coloration syntaxique (nouvelle API)
  vim.wo[win].winhl = 'Normal:Normal,FloatBorder:FloatBorder'
  
  -- Highlights personnalisés
  vim.cmd([[
    highlight CheatsheetTitle guifg=#89b4fa gui=bold
    highlight CheatsheetBorder guifg=#585b70
    highlight CheatsheetKey guifg=#f38ba8 gui=bold
    highlight CheatsheetDesc guifg=#cdd6f4
  ]])
end

-- Raccourci principal
vim.keymap.set('n', '<leader>k', M.show, { desc = '📚 Cheatsheet Neovim' })


-- Notification au chargement
vim.notify("📚 Cheatsheet chargé ! Appuie sur <leader>k", vim.log.levels.INFO)

return M

-- ════════════════════════════════════════
-- 📝 Aide-mémoire
-- ════════════════════════════════════════
--[[
Raccourci principal :
  <leader>k - Ouvrir le cheatsheet

Catégories :
  <leader>km - Marks (marques)
  <leader>kt - Text Objects (ci/ca/di/da)
  <leader>kn - Navigation
  <leader>kv - Visual Mode
  <leader>kw - Windows & Buffers
  <leader>ks - Search & Replace
  <leader>kf - Files
  <leader>ku - Undo/Redo
  <leader>kr - Registers

Exemples pratiques :
  ci"  - Change inside "" (change le texte entre guillemets)
  da{  - Delete around {} (supprime {} et contenu)
  vi(  - Visual inside () (sélectionne contenu de ())
  ma   - Créer mark 'a'
  'a   - Aller au mark 'a'
  f<char> - Aller à <char> sur la ligne
  *    - Chercher mot sous curseur
]]
