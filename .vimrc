scriptencoding utf-8
set encoding=utf-8

" auto install vim-plug (if required)
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" new line

if empty(glob('~/.vim/snippets'))
    silent !ln -sf $(dirname $(readlink ~/.vimrc))/snippets ~/.vim/snippets
endif

call plug#begin()

Plug 'embear/vim-localvimrc'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'mhinz/vim-signify'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
" Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'
Plug 'ervandew/supertab'
" only load/install youcompleteme if environment variable YCM is set
" if $YCM
"     Plug 'valloric/youcompleteme'
" endif
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  " pacman -S python-greenlet python-pip
  " pip3 install --user pynvim
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
" Plug 'SirVer/ultisnips'
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
Plug 'machakann/vim-highlightedyank'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

" filetypes
" Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
" Plug 'quramy/tsuquyomi'  " tsserver client
Plug 'chr4/nginx.vim'
Plug 'plasticboy/vim-markdown'
Plug 'digitaltoad/vim-pug'
Plug 'cakebaker/scss-syntax.vim'
Plug 'posva/vim-vue'
" Plug 'maxmellon/vim-jsx-pretty'
Plug 'tpope/vim-git'

" theme
" Plug 'chriskempson/base16-vim'
" Plug 'vim-scripts/dante.vim'
" Plug 'ayu-theme/ayu-vim'
Plug 'morhetz/gruvbox'

call plug#end()

function! PullVimrc()
    !git --git-dir=$(dirname $(readlink ~/.vimrc))/.git --work-tree=$(dirname $(readlink ~/.vimrc)) pull
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
" set virtualedit=all
set nostartofline
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
nnoremap <silent> <leader>n :NERDTreeFind<CR>
nnoremap <silent> <leader>m :NERDTreeToggle<CR>
nnoremap <leader>p :call PullVimrc()<CR>
nnoremap Y y$

" YouCompleteMe maps
" nnoremap <leader>gg :YcmCompleter GoTo<CR>
" nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
" nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
" nnoremap <leader>gD :YcmCompleter GoToDefinition<CR>
" nnoremap <leader>Gd :YcmCompleter GetDoc<CR>
" nnoremap <leader>Gt :YcmCompleter GetType<CR>
" nnoremap <leader>f :YcmCompleter FixIt<CR>

" ale
nnoremap <leader>ah :ALEHover<CR>
nnoremap <leader>ad :ALEGoToDefinition<CR>
nnoremap <leader>at :ALEGoToTypeDefinition<CR>
" nnoremap <leader>af :ALEFix<CR>
nnoremap <leader>af <Plug>(ale_fix)

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

nmap ]g <plug>(signify-next-hunk)
nmap [g <plug>(signify-prev-hunk)
nmap ]c :cnext<CR>zv
nmap [c :cprevious<CR>zv
" nmap ]l :lnext<CR>
" nmap [l :lprevious<CR>
nmap ]l <Plug>(ale_next_wrap)
nmap [l <Plug>(ale_previous_wrap)
nmap ]b :bnext<CR>
nmap [b :bprevious<CR>

" jsdoc (leader j already used for window grow height)
" nmap <silent> <leader>j ?function<cr>:noh<cr><Plug>(jsdoc)

" in vim version < 8 remap y key
if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
endif

" auto-pairs
" do not add mapping for <C-h>
let g:AutoPairsMapCh = 0

" prettier
let g:prettier#exec_cmd_async = 1
" when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 0
let g:prettier#quickfix_auto_focus = 0
let g:prettier#autoformat = 0
" autocmd BufWritePre,TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" YouCompleteMe
" let g:ycm_complete_in_comments = 1
" let g:ycm_collect_identifiers_from_comments_and_strings = 1

" deoplate
if v:version >= 800
    let g:deoplete#enable_at_startup = 1
endif
" inoremap <silent><expr> <TAB>
"             \ pumvisible() ? "\<C-n>" :
"             \ <SID>check_back_space() ? "\<TAB>" :
"             \ deoplete#mappings#manual_complete()
" function! s:check_back_space() abort "{{{
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1]  =~ '\s'
" endfunction"}}}
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-l>     <Plug>(neosnippet_expand_or_jump)
smap <C-l>     <Plug>(neosnippet_expand_or_jump)
xmap <C-l>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
" imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
let g:neosnippet#snippets_directory = '~/.vim/snippets'


" indexed-search
let g:indexed_search_line_info = 1
let g:indexed_search_shortmess = 1
let g:indexed_search_numbered_only = 1

" simplyfold
let g:SimpylFold_fold_docstring = 0

" status line
set laststatus=2
set noshowmode

" lightline (status bar)
let g:lightline = {}
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

let g:lightline.colorscheme = 'powerline'

let g:lightline.active = {
    \       'left': [ [ 'mode', 'paste' ],
    \                 [ 'readonly', 'relativepath', 'modified' ] ],
    \       'right': [ [ 'lineinfo' ],
    \                  [ 'percent' ],
    \                  [ 'fileformat', 'fileencoding', 'filetype' ],
    \                  [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ], ]
    \   }

let g:lightline.inactive = {
    \       'left': [ [ 'relativepath' ] ],
    \       'right': [ [ 'lineinfo' ],
    \                  [ 'percent' ] ]
    \   }

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
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline=%{LinterStatus()}
set statusline+=%*

" tsuquyomi with syntastic
" let g:tsuquyomi_disable_quickfix = 1
" let g:tsuquyomi_disable_default_mappings = 1
" let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint'] " You shouldn't use 'tsc' checker.
" let g:syntastic_vue_checkers = ['tsuquyomi']
" let g:syntastic_typescript_checkers = ['tsc', 'eslint', 'tslint'] " You shouldn't use 'tsc' checker.
" let g:syntastic_typescripttsx_checkers = g:syntastic_typescript_checkers
" " let g:syntastic_typescript_checkers = ['tslint'] " You shouldn't use 'tsc' checker.
" autocmd Filetype typescript call SetTypescriptOptions()
" autocmd Filetype typescript.tsx call SetTypescriptOptions()
" function SetTypescriptOptions()
"     if executable('node_modules/.bin/tsc')
"         let b:syntastic_typescript_tsc_exec = 'node_modules/.bin/tsc'
"         let b:syntastic_typescripttsx_tsc_exec = b:syntastic_typescript_tsc_exec
"     endif
"
"     if executable('node_modules/.bin/eslint')
"         let b:syntastic_typescript_eslint_exec = 'node_modules/.bin/eslint'
"         let b:syntastic_typescripttsx_eslint_exec = b:syntastic_typescript_eslint_exec
"     endif
"
"     " let s:tslint_path = system('PATH=$(npm bin):$PATH && which tslint')
"     " let b:syntastic_typescript_tslint_exec = substitute(s:tslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
"     if executable('node_modules/.bin/tslint')
"         let b:syntastic_typescript_tslint_exec = 'node_modules/.bin/tslint'
"         let b:syntastic_typescripttsx_tslint_exec = b:syntastic_typescript_tslint_exec
"     endif
" endfunction

" nerdtree
let g:NERDTreeShowHidden = 1
let NERDTreeIgnore = ['\.pyc$']

" nerd commenter
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDDefaultAlign = 'left'
"
" " UltiSnips
" let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
" let g:UltiSnipsEditSplit = 'vertical'

" syntastic
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_javascript_checkers=['eslint']
" autocmd Filetype javascript call SetJavascriptOptions()
" function SetJavascriptOptions()
"     if executable('node_modules/.bin/eslint')
"         let b:syntastic_javascript_eslint_exec = 'node_modules/.bin/eslint'
"     endif
" endfunction

" ale
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 0
let g:ale_completion_enabled = 1
" set omnifunc=ale#completion#OmniFunc
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'typescript': ['eslint', 'tslint'],
\   'typescripttsx': ['eslint', 'tslint'],
\}

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

if has("autocmd")
  let black_pipeline  = "black --fast --skip-string-normalization --quiet"
  let black_pipeline .= " -"    " read from stdin
  autocmd FileType python let &l:formatprg=black_pipeline
endif

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
