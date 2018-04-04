" auto install vim-plug (if required)
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'

" theme
"Plug 'chriskempson/base16-vim'
"Plug 'vim-scripts/dante.vim'
Plug 'ayu-theme/ayu-vim'

call plug#end()

set number relativenumber
set nowrap
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set cursorline
set hlsearch
set scrolloff=10
set splitbelow
set splitright
set listchars=eol:¬,tab:→·,trail:~,extends:>,precedes:<,space:·
"set list

autocmd BufWritePre * :%s/\s\+$//e
filetype plugin on
syntax on

" nohighlight
nnoremap <CR> :noh<CR><CR>

nmap ,n :NERDTreeFind<CR>
nmap ,m :NERDTreeToggle<CR>

" slim cursor in insert mode
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"


" CtrlP settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.gz,*.tgz
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

if &term=~'linux'
    " console on linux
elseif &term=~'xterm'
    " terminal running under X
    set background=dark
    set termguicolors
    "colorscheme dante
    let ayucolor="dark"
    colorscheme ayu
endif

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
