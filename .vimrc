scriptencoding utf-8
set encoding=utf-8

" auto install vim-plug (if required)
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if empty(glob('~/.vim/UltiSnips'))
    silent !ln -sf $(dirname $(readlink ~/.vimrc))/UltiSnips ~/.vim/UltiSnips
endif

call plug#begin()

Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'vim-syntastic/syntastic'
Plug 'embear/vim-localvimrc'
Plug 'SirVer/ultisnips'
Plug 'plasticboy/vim-markdown'
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'cakebaker/scss-syntax.vim'
Plug 'digitaltoad/vim-pug'
Plug 'nelstrom/vim-visual-star-search'
Plug 'editorconfig/editorconfig-vim'

" theme
" Plug 'chriskempson/base16-vim'
" Plug 'vim-scripts/dante.vim'
" Plug 'ayu-theme/ayu-vim'
Plug 'morhetz/gruvbox'

call plug#end()

function! PullVimrc()
    !git --git-dir=$(dirname $(readlink -f ~/.vimrc))/.git --work-tree=$(dirname $(readlink -f ~/.vimrc)) pull
    source $MYVIMRC
    PlugClean
    PlugUpdate
endfunction

function! AppendFileType()
    if has_key(g:fileTypeAppends, &filetype)
        if g:fileTypeAppends[&filetype] == 'python3'
            set filetype=python.python3
        elseif g:fileTypeAppends[&filetype] == 'python2'
            set filetype=python.python2
        endif
    endif
endfunction

set number relativenumber
set nowrap
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set cursorline
set hlsearch
set incsearch
set showcmd
set hidden
set scrolloff=10
set history=2000
set splitbelow
set splitright
set autoread
set wildmode=longest,list
if exists('&emoji')
    set noemoji
endif
" set showbreak='↪\ '
let &showbreak="\u21aa "
" set listchars=eol:¬,tab:→\ ,trail:~,extends:>,precedes:<,space:·,nbsp:•
set listchars=eol:¬,tab:→\ ,trail:~,extends:>,precedes:<,nbsp:•
if has("patch-7.4.710")
    set listchars+=space:·
endif
" set list
let g:fileTypeAppends = { 'python': 'python3', }
let g:vue_disable_pre_processors=1
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

autocmd BufWritePre * :%s/\s\+$//e
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd BufReadPost * :call AppendFileType()
filetype plugin on
syntax on

let mapleader = " "

nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
nnoremap <silent> <F2> :set invnumber invrelativenumber<CR>:GitGutterToggle<CR>:SyntasticToggleMode<CR>
nnoremap <silent> <leader>h :10winc <<CR>
nnoremap <silent> <leader>l :10winc ><CR>
nnoremap <silent> <leader>j :10winc +<CR>
nnoremap <silent> <leader>k :10winc -<CR>
nnoremap <leader>p :call PullVimrc()<CR>
inoremap <silent> jk <Esc>

nmap <leader>n :NERDTreeFind<CR>
nmap <leader>m :NERDTreeToggle<CR>

" git gutter
nmap ghp <Plug>GitGutterPreviewHunk
nmap ghs <Plug>GitGutterStageHunk
nmap ghu <Plug>GitGutterUndoHunk

" slim cursor in insert mode
let &t_SI = "\<Esc>[6 q"
if exists('&t_SR')
    let &t_SR = "\<Esc>[4 q"
endif
let &t_EI = "\<Esc>[2 q"

" localvimrc
let g:localvimrc_name = [ '.lvimrc', '.local.vimrc', '.local.gitignore.vimrc' ]
let g:localvimrc_persistent = 1

" vim-markdown
let g:vim_markdown_folding_disabled = 1

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
let NERDTreeIgnore = ['\.pyc$']

" UltiSnips
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
let g:UltiSnipsEditSplit = 'vertical'

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers=['eslint']

set background=dark

if &term=~'linux'
    " console on linux
    colorscheme slate
    set nolist
elseif &term=~'xterm'
    " terminal running under X
    if exists('&termguicolors')
        set termguicolors
    endif
    " colorscheme dante
    " let ayucolor="dark"
    " colorscheme ayu
    " enable italic font
    let &t_ZH="\e[3m"
    let &t_ZR="\e[23m"
    let g:gruvbox_contrast_dark = 'hard'
    let g:gruvbox_italic = 1
    colorscheme gruvbox
endif

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
