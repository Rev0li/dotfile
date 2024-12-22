set number
set shiftwidth=4
set tabstop=4
colorscheme vim 
call plug#begin('~/.local/share/nvim/plugged')

" Ajoute nvim-tree
Plug 'kyazdani42/nvim-tree.lua'

call plug#end()

" Configuration de nvim-tree
lua << EOF
require'nvim-tree'.setup {
    view = {
        width = 25,   -- Largeur de la colonne de fichiers
        side = 'left' -- Colonne à gauche
    }
}
EOF

source /usr/share/vim/vim85/plugin/stdheader.vim

noremap <C-h> :Stdheader<CR>
noremap <C-d> :NvimTreeToggle<CR>
nnoremap <C-s> :w<CR>
