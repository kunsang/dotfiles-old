" Tabs and Spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set backspace=indent,eol,start
set expandtab
set autoindent
set smartindent
set smarttab

" Misc
set number
set ruler
set showcmd
set showmatch
set nowrap
set hidden
set modeline
set autoread       " auto-reload modified files (with no local changes)
set nocompatible   " don't try to be compatible with vi
set ignorecase     " ignore case in search
set smartcase      " override ignorecase if uppercase is used in search string
set report=0       " report all changes
set laststatus=2   " always show status-line
set cursorline     " highlight current line
set scrolloff=4
set nofoldenable
set shell=/bin/zsh

" Wildmenu completion {{{
set wildmenu
set wildmode=list:longest

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store?                      " OSX bullshit
set wildignore+=*vendor/bundle/*,public/assets/* " Rails specific
set wildignore+=*node_modules/*                  " npm modules
set wildignore+=*target/*,resources/public/*     " clojure projects
" }}}

" Swaps and backups
set nobackup                           " do not keep backups after close
set nowritebackup                      " do not keep a backup while working
set noswapfile                         " don't keep swp files either
set backupdir=$HOME/.vim/backup        " store backups under ~/.vim/backup
set backupcopy=yes                     " keep attributes of original file
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set directory=$HOME/.vim/swap,~/tmp,.      " keep swp files under ~/.vim/swap
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

" Show trailing whitespace
set list listchars=tab:→\ ,trail:·

set autowrite

" Better search
set hlsearch
set incsearch

" Show trailing white-space
let ruby_space_errors = 1
let c_space_errors = 1
let javascript_space_errors = 1

let mapleader = ","

" Easy command mode switch
inoremap jj <Esc>

" Yank to OS X pasteboard.
noremap <leader>y "*y

" Paste from OS X pasteboard without messing up indent.
noremap <leader>p :set paste<CR>"*p<CR>:set nopaste<CR>
noremap <leader>P :set paste<CR>"*P<CR>:set nopaste<CR>

" Fix backspace key in xterm
" inoremap <BS>

inoremap <C-l> <C-x><C-l>

inoremap <C-f> function () {}<Left>

" Enable mouse in insert and normal mode
" set mouse=vin

" Create an empty line underneath without moving the cursor
noremap <CR> mlo<Esc>`l

" Indent with spacebar
noremap <space> >>
noremap <BS> <<

" Move easily between ^ and $
noremap <C-h> ^
noremap <C-l> $

nnoremap Y y$
nnoremap D d$

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" It's 2011.
noremap j gj
noremap k gk

" After copying a visual block, keep cursor at end of block for easy pasting
vnoremap y y`>

" Moving around in splits
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" Removing arrow keys
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" Indent whole file
map <Leader>i gg=G

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" plugin on GitHub repo

Plugin 'gmarik/vundle'
Plugin 'mattn/zencoding-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'sjl/gundo.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ervandew/supertab'
Plugin 'majutsushi/tagbar'
Plugin 'janx/vim-rubytest'
Plugin 'Lokaltog/vim-powerline'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mattn/gist-vim'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'tpope/vim-rails'
Plugin 'vim-scripts/buftabs'
Plugin 'gregsexton/gitv'
Plugin 'kana/vim-smartinput'
Plugin 'nono/vim-handlebars'
Plugin 'guns/vim-clojure-static'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'tpope/vim-haml'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set background=dark
colorscheme ir_black
syntax on

