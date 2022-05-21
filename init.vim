set nu
set nu
syntax on
filetype plugin indent on
inoremap jk <Esc>
let mapleader = " "
call plug#begin()
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'numToStr/Comment.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'wakatime/vim-wakatime'
Plug 'ellisonleao/glow.nvim', {'branch': 'main'}
Plug 'rust-lang/rust.vim'
call plug#end()
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
lua require('Comment').setup()
" colorscheme tokyonight
