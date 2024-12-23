set number
set shiftwidth=4
set tabstop=4
let mapleader = ","

call plug#begin(stdpath('data') . '/plugged')

" Ajoute nvim-tree et gruvbox
Plug 'kyazdani42/nvim-tree.lua'
Plug 'morhetz/gruvbox'

call plug#end()

" Vérifie si le thème est disponible avant de l'appliquer
if !empty(glob(stdpath('data') . '/plugged/gruvbox/colors/gruvbox.vim'))
    colorscheme gruvbox
else
    echo "Theme gruvbox not found, using default"
    colorscheme default
endif

lua require('init')

" Ouvrir un terminal avec un split horizontal
nnoremap <leader>t :split<CR>:terminal<CR> i <CR>

" Échap pour quitter le mode insertion dans le terminal
tnoremap <Esc> <C-\><C-n>

" Raccourci pour fermer une fenêtre avec <leader>q
nnoremap <leader>q :q<CR>

" NvimTree toggle
noremap <C-d> :NvimTreeToggle<CR>

" Sauvegarde rapide
nnoremap <C-s> :w<CR>

