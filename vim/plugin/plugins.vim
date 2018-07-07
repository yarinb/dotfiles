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
Plug 'blarghmatey/split-expander'
Plug 'farmergreg/vim-lastplace'
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
Plug 'vim-ruby/vim-ruby'
Plug 'jiangmiao/auto-pairs'
Plug 'elzr/vim-json'
Plug 'tpope/vim-markdown'
Plug 'groenewege/vim-less'
Plug 'othree/html5.vim', { 'for': ['html'] }"
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx']  }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx']  }
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx']  }
if has('macunix')
    Plug 'zerowidth/vim-copy-as-rtf'
endif


" Syntax errors
Plug 'w0rp/ale', { 'do': 'npm install -g prettier' }
Plug 'ntpeters/vim-better-whitespace'

" Markdown support
Plug 'junegunn/goyo.vim'

" Git support
Plug 'tpope/vim-fugitive'

" Themes
Plug 'tomasr/molokai'
Plug 'dracula/vim'
Plug 'junegunn/seoul256.vim'
Plug 'chriskempson/base16-vim'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'
Plug 'joshdick/onedark.vim'
Plug 'w0ng/vim-hybrid'

" Testing
Plug 'janko-m/vim-test'

" Display hex colors
Plug 'chrisbra/Colorizer'

" Python
Plug 'fisadev/vim-isort', { 'for': 'python' }
Plug 'ambv/black', { 'for': 'python', 'rtp': 'vim' }
Plug 'davidhalter/jedi-vim'

call plug#end()
