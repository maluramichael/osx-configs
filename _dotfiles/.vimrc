@REM call plug#begin('$DEV_HOME/vim/plugged')
@REM   Plug 'sbdchd/neoformat'
@REM   Plug 'junegunn/fzf', { 'do': './install --bin' }
@REM   Plug 'terryma/vim-multiple-cursors'
@REM   Plug 'preservim/nerdtree'
@REM   Plug 'editorconfig/editorconfig-vim'
@REM   Plug 'mattn/emmet-vim'
@REM   Plug 'rust-lang/rust.vim'
@REM call plug#end()

@REM set tabstop=2       " number of visual spaces per TAB
@REM set softtabstop=2   " number of spaces in tab when editing
@REM set shiftwidth=2    " number of spaces to use for autoindent
@REM set expandtab       " tabs are space
@REM set autoindent
@REM set copyindent      " copy indent from the previous line
@REM set clipboard+=unnamedplus

@REM set hidden
@REM set number                   " show line number
@REM set showcmd                  " show command in bottom bar
@REM " set cursorline               " highlight current line
@REM set wildmenu                 " visual autocomplete for command menu
@REM set showmatch                " highlight matching brace
@REM set laststatus=2             " window will always have a status line
@REM set nobackup
@REM set noswapfile

@REM set incsearch       " search as characters are entered
@REM set hlsearch        " highlight matche
@REM set ignorecase      " ignore case when searching
@REM set smartcase       " ignore case if search pattern is lower case
@REM                     " case-sensitive otherwise
@REM set foldenable
@REM set foldlevelstart=10  " default folding level when buffer is opened
@REM set foldnestmax=10     " maximum nested fold
@REM set foldmethod=syntax  " fold based on indentation

@REM nmap <leader>ev :e $MYVIMRC<CR>
@REM nmap <leader>sv :so $MYVIMRC<CR>

@REM " better ESC
@REM inoremap jj <esc>

@REM " fast save and close
@REM nmap <leader>w :w<CR>
@REM nmap <leader>x :x<CR>
@REM nmap <leader>q :q<CR>

@REM " insert blank line before current line without leaving insert mode
@REM imap <leader>o <c-o><s-o>

@REM " move up/down consider wrapped lines
@REM nnoremap j gj
@REM nnoremap k gk


@REM " config nerdtree
@REM map <C-x> :NERDTreeToggle<CR>
@REM autocmd StdinReadPre * let s:std_in=1
@REM autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
@REM autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
@REM autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

@REM " change cursor line to indicate if vim is in insert mode
@REM " thanks to https://stackoverflow.com/a/6489348
@REM autocmd InsertEnter * set cul
@REM autocmd InsertLeave * set nocul
