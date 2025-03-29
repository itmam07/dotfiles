"==========================================
" 1. Bootstrap vim-plug if not installed
"==========================================
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"==========================================
" 2. Initialize Plugin Manager
"==========================================
call plug#begin()

" Nord Theme
Plug 'arcticicestudio/nord-vim'

" File Explorer
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'  " Adds icons

" Status Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Fuzzy Finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Git Integration
Plug 'tpope/vim-fugitive'

call plug#end()

"==========================================
" 3. General Settings
"==========================================
set number                " Show line numbers
set relativenumber        " Relative line numbers
set mouse=a               " Enable mouse support
set clipboard=unnamedplus " Use system clipboard
set ignorecase            " Case-insensitive search
set smartcase             " Smart case search
set expandtab             " Convert tabs to spaces
set shiftwidth=4          " Tab size
set tabstop=4             " Spaces per tab
set termguicolors         " Enable true colors
set background=dark       " Ensure dark theme
set hlsearch              " Highlight search
colorscheme nord

"==========================================
" 4. Keybindings 
"==========================================

" Use space as the leader key
let mapleader=" "

" Save with Ctrl + S
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>

" Quit with Ctrl + Q
nnoremap <C-q> :q<CR>

" Better window navigation
nnoremap <S-h> <C-w>h
nnoremap <S-j> <C-w>j
nnoremap <S-k> <C-w>k
nnoremap <S-l> <C-w>l

" Buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-n> :new <CR>

" Clear search highlighting
nnoremap <leader>c :nohlsearch<CR>

" Open NERDTree with leader + n
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeToggle<CR>

" Toggle file explorer with leader + e
" nnoremap <leader>e :Ex<CR>

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Move lines up and down in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Center screen when scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" Fast saving and quitting
nnoremap <leader>c :bd<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"==========================================
" 4. NERDTree Configuration
"==========================================
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
autocmd VimEnter * NERDTree | wincmd p  " Open NERDTree on startup
"nnoremap <C-n> :NERDTreeToggle<CR>  " Ctrl+N to toggle NERDTree

"==========================================
" 5. Airline Configuration
"==========================================
let g:airline_powerline_fonts = 1
let g:airline_theme='nord'

"==========================================
" 6. FZF Configuration
"==========================================
let g:fzf_layout = { 'down': '~40%' }  " Show results in popup
nnoremap <C-p> :Files<CR>              " Ctrl+P for fuzzy file search
nnoremap <Leader>rg :Rg<Space>         " Search with ripgrep

"==========================================
" 7. LSP & Autocomplete (CoC)
"==========================================
let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-pyright']
nnoremap <silent> gd <Plug>(coc-definition)   " Jump to definition
nnoremap <silent> K :call CocAction('doHover')<CR> " Show documentation
