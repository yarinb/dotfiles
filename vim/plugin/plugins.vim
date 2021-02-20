call plug#begin('~/.vim/plugged')

" Addons
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'yegappan/mru'				" easy access to a list of recently opened/edited files in Vim.
Plug 'airblade/vim-gitgutter'
"Plug 'ervandew/supertab'
Plug 'tpope/vim-rhubarb'        " GitHub extension for fugitive.vim
Plug 'tpope/vim-repeat'         " enable repeating supported plugin maps with '.
Plug 'tpope/vim-surround'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'mileszs/ack.vim'
Plug 'nathanaelkane/vim-indent-guides', { 'on': [ 'IndentGuidesEnable', 'IndentGuidesDisable', 'IndentGuidesToggle' ] }
" Indent guides enable
let g:indent_guides_enable_on_vim_startup=1
"Plug 'itchyny/lightline.vim'
Plug 'ludovicchabant/vim-gutentags'

" Completion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-jedi', { 'for': 'python' }

Plug 'Shougo/neosnippet-snippets'
let g:neosnippet#data_directory = $VARPATH.'/snippets'
Plug 'Shougo/neosnippet.vim'

" Tmux integration
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" File system navigation
Plug 'tpope/vim-eunuch'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Syntax highlighting
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-markdown'

" Markdown support
Plug 'junegunn/goyo.vim'

" Git support
Plug 'tpope/vim-fugitive'

" Themes
Plug 'morhetz/gruvbox'

call plug#end()
