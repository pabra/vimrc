scriptencoding utf-8
set encoding=utf-8

" auto install vim-plug (if required)
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" new line

if empty(glob('~/.vim/UltiSnips'))
    silent !ln -sf $(dirname $(readlink ~/.vimrc))/UltiSnips ~/.vim/UltiSnips
endif

call plug#begin()

Plug 'embear/vim-localvimrc'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-signify'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-syntastic/syntastic'
Plug 'ervandew/supertab'
" only load/install youcompleteme if environment variable YCM is set
if $YCM
    Plug 'valloric/youcompleteme'
endif
Plug 'SirVer/ultisnips'
Plug 'henrik/vim-indexed-search'        " needs to be before visual star search
Plug 'nelstrom/vim-visual-star-search'
Plug 'editorconfig/editorconfig-vim'
Plug 'terryma/vim-expand-region'
Plug 'matze/vim-move'
Plug 'majutsushi/tagbar'
Plug 'tmhedberg/simpylfold'
Plug 'dhruvasagar/vim-table-mode'
Plug 'blueyed/vim-diminactive'
Plug 'heavenshell/vim-jsdoc'

" filetypes
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'chr4/nginx.vim'
Plug 'plasticboy/vim-markdown'
Plug 'digitaltoad/vim-pug'
Plug 'cakebaker/scss-syntax.vim'
Plug 'posva/vim-vue'
Plug 'tpope/vim-git'

" theme
" Plug 'chriskempson/base16-vim'
" Plug 'vim-scripts/dante.vim'
" Plug 'ayu-theme/ayu-vim'
Plug 'morhetz/gruvbox'

call plug#end()

function! PullVimrc()
    !git --git-dir=$(dirname $(readlink -f ~/.vimrc))/.git --work-tree=$(dirname $(readlink -f ~/.vimrc)) pull
    source $MYVIMRC
    PlugUpgrade
    PlugClean
    PlugUpdate
endfunction

function! AppendFileType()
    if has_key(g:fileTypeAppends, &filetype)
        exe 'set filetype=' . &filetype . '.' . substitute(g:fileTypeAppends[&filetype], '[^a-zA-Z0-9\_-]\+', '', 'g')
    endif
endfunction

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind if NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
    if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
        NERDTreeFind
        wincmd p
    endif
endfunction

" set number relativenumber
set number
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
set ttimeoutlen=50
set splitbelow
set splitright
set autoread
set nospell
set spelllang=en_us
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
autocmd BufWinEnter * :call SyncTree()
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd BufReadPost * :call AppendFileType()
autocmd QuickFixCmdPost *grep* cwindow
filetype plugin on
syntax on

let mapleader = " "

nnoremap <silent> <C-l> :<C-u>nohlsearch<CR>:syntax sync fromstart<CR><C-l>
nnoremap <silent> <F2> :set invnumber<CR>:SignifyToggle<CR>:SyntasticToggleMode<CR>
nnoremap <silent> <leader>s :set spell!<CR>
nnoremap <silent> <leader>w :set wrap!<CR>
nnoremap <silent> <leader>h :10winc <<CR>
nnoremap <silent> <leader>l :10winc ><CR>
nnoremap <silent> <leader>j :10winc +<CR>
nnoremap <silent> <leader>k :10winc -<CR>
nnoremap <silent> <leader>dg :diffget<CR>:diffupdate<CR>
nnoremap <silent> <leader>dp :diffput<CR>:diffupdate<CR>
nnoremap <silent> <leader>pb :CtrlPBuffer<CR>
nnoremap <silent> <leader>pt :CtrlPBufTagAll<CR>
nnoremap <leader>p :call PullVimrc()<CR>
nnoremap Y y$

inoremap <silent>jk <Esc>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-k> <Up>

vnoremap <silent> <leader>dg :'<,'>diffget<CR>:diffupdate<CR>
vnoremap <silent> <leader>dp :'<,'>diffput<CR>:diffupdate<CR>
vnoremap <silent>> >gv
vnoremap <silent>< <gv

" map %% in command mode to be expanded to the path of current buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

nmap <leader>n :NERDTreeFind<CR>
nmap <leader>m :NERDTreeToggle<CR>
nmap <leader>t :TagbarToggle<CR>

" better previous/next mappings
nmap ö [
nmap ä ]
omap ö [
omap ä ]
xmap ö [
xmap ä ]
nmap öö [[
nmap ää ]]
omap öö [[
omap ää ]]
xmap öö [[
xmap ää ]]

nmap ]g <Plug>GitGutterNextHunk
nmap [g <Plug>GitGutterPrevHunk
nmap ]c :cnext<CR>zv
nmap [c :cprevious<CR>zv
nmap ]l :lnext<CR>
nmap [l :lprevious<CR>
nmap ]b :bnext<CR>
nmap [b :bprevious<CR>

" hunk jumping
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)

" jsdoc
nmap <silent> <leader>j ?function<cr>:noh<cr><Plug>(jsdoc)

" auto-pairs
" do not add mapping for <C-h>
let g:AutoPairsMapCh = 0

" YouCompleteMe
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1

" indexed-search
let g:indexed_search_line_info = 1
let g:indexed_search_shortmess = 1
let g:indexed_search_numbered_only = 1

" simplyfold
let g:SimpylFold_fold_docstring = 0

" status line
set laststatus=2
set noshowmode

" vim move
let g:move_map_keys = 0
" let g:move_key_modifier = 'C'
vmap <C-j> <Plug>MoveBlockDown
vmap <C-k> <Plug>MoveBlockUp
vmap <C-h> <Plug>MoveBlockLeft
vmap <C-l> <Plug>MoveBlockRight
nmap <C-j> <Plug>MoveLineDown
nmap <C-k> <Plug>MoveLineUp

" vcs/git gutter
let g:signify_vcs_list = [ 'git' ]


" localvimrc
let g:localvimrc_name = [ '.lvimrc', '.local.vimrc', '.local.gitignore.vimrc' ]
let g:localvimrc_persistent = 1

" vim-markdown
let g:vim_markdown_folding_disabled = 1

" CtrlP settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.gz,*.tgz,*.pyc
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_cmd = 'CtrlPMixed'

" sytastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" nerdtree
let g:NERDTreeShowHidden = 1
let NERDTreeIgnore = ['\.pyc$']

" nerd commenter
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDDefaultAlign = 'left'

" UltiSnips
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
let g:UltiSnipsEditSplit = 'vertical'

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers=['eslint']

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

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
    " slim cursor in insert mode
    let &t_SI = "\<Esc>[6 q"
    if exists('&t_SR')
        let &t_SR = "\<Esc>[4 q"
    endif
    let &t_EI = "\<Esc>[2 q"
    " colorscheme dante
    " let ayucolor="dark"
    " colorscheme ayu
    " enable italic font
    let &t_ZH="\e[3m"
    let &t_ZR="\e[23m"
    let g:gruvbox_contrast_dark = 'hard'
    let g:gruvbox_guisp_fallback = 'bg'
    let g:gruvbox_italic = 1
    let g:gruvbox_sign_column = 'dark0_hard'
    let g:gruvbox_number_column = 'dark0_hard'
    colorscheme gruvbox
    highlight Normal ctermbg=Black guibg=Black
    highlight CursorLine ctermbg=234 guibg=#161819
    highlight ColorColumn ctermbg=234 guibg=#1d2021
endif

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
