"vim-plug{{{
call plug#begin('~/.local/share/nvim/plugged')
"vim
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/httplog' "usage: setf httplog
Plug 'will133/vim-dirdiff'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'triglav/vim-visual-increment'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot' "language pack
Plug 'markonm/traces.vim' "substitute
Plug 'liuchengxu/vista.vim'
Plug 'xolox/vim-misc' "vim-colorscheme-switcher dependency
Plug 'xolox/vim-colorscheme-switcher'
Plug 'blueyed/smarty.vim'
Plug 'justinmk/vim-dirvish'
" Plug 'jsfaint/gen_tags.vim'
Plug 'liuchengxu/graphviz.vim'
"Plug 'ntpeters/vim-better-whitespace'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'neovim/nvim-lspconfig'
" Plug 'wellle/context.vim'

"language-server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'kannokanno/previm'


"php
Plug 'shawncplus/phpcomplete.vim'
Plug 'vim-scripts/PDV--phpDocumentor-for-Vim'
" Plug 'phpactor/phpactor', {'for': 'php', 'branch': 'master', 'do': 'composer install --no-dev -o'}
" Require ncm2 and this plugin
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
" Plug 'phpactor/ncm2-phpactor'
" Plug 'vim-vdebug/vdebug'

"javascript
Plug 'heavenshell/vim-jsdoc'
Plug 'pangloss/vim-javascript'

"colorscheme
Plug 'drewtempelmeyer/palenight.vim'
Plug 'kjssad/quantum.vim'
Plug 'kshenoy/vim-sol'
Plug 'mhartington/oceanic-next'
Plug 'sainnhe/sonokai'
Plug 'franbach/miramare'

Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
Plug 'folke/lsp-colors.nvim'
Plug 'rafamadriz/neon'
Plug 'EdenEast/nightfox.nvim'
call plug#end()
"}}}
