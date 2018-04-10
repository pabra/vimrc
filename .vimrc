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
Plug 'vim-syntastic/syntastic'
Plug 'thinca/vim-localrc'
Plug 'SirVer/ultisnips'

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
set autoread
set listchars=eol:¬,tab:→·,trail:~,extends:>,precedes:<,space:·
"set list

autocmd BufWritePre * :%s/\s\+$//e
autocmd BufReadPost fugitive://* set bufhidden=delete
filetype plugin on
syntax on

" nohighlight
nnoremap <silent> <CR> :noh<CR><CR>
nnoremap <silent> <F2> :set invnumber invrelativenumber<CR>:GitGutterToggle<CR>
"nnoremap <Leader>w" ciw""<Esc>P
"nnoremap <Leader>w' ciw''<Esc>P
"nnoremap <Leader>w` ciw``<Esc>P
"nnoremap <Leader>w( ciw()<Esc>P
"nnoremap <Leader>w) ciw()<Esc>P
"nnoremap <Leader>w[ ciw[]<Esc>P
"nnoremap <Leader>w] ciw[]<Esc>P
"nnoremap <Leader>w{ ciw{}<Esc>P
"nnoremap <Leader>w} ciw{}<Esc>P
"nnoremap <Leader>w< ciw<><Esc>P
"nnoremap <Leader>w> ciw<><Esc>P

nmap ,n :NERDTreeFind<CR>
nmap ,m :NERDTreeToggle<CR>

" slim cursor in insert mode
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"


" CtrlP settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.gz,*.tgz,*.pyc
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

" sytastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" nerdtree
let g:NERDTreeShowHidden = 1

" UltiSnips
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
let g:UltiSnipsEditSplit = 'vertical'

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers=['eslint']

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
