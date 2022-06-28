let fancy_symbols_enabled = 1

let using_neovim = has('nvim')
let using_vim = !using_neovim

let vim_plug_just_installed = 0
if using_neovim
    let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
else
    let vim_plug_path = expand('~/.vim/autoload/plug.vim')
endif

if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    if using_neovim
        silent !mkdir -p ~/.config/nvim/autoload
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        silent !mkdir -p ~/.vim/autoload
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
    let vim_plug_just_installed = 1
endif

if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

if using_neovim
    call plug#begin("~/.config/nvim/plugged")
else
    call plug#begin("~/.vim/plugged")
endif

Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/IndexedSearch'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
if using_neovim && vim_plug_just_installed
    Plug 'Shougo/deoplete.nvim', {'do': ':autocmd VimEnter * UpdateRemotePlugins'}
else
    Plug 'Shougo/deoplete.nvim'
endif
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'Shougo/context_filetype.vim'
Plug 'davidhalter/jedi-vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'sheerun/vim-polyglot'
Plug 'lilydjwg/colorizer'
Plug 't9md/vim-choosewin'
Plug 'valloric/MatchTagAlways'
Plug 'mhinz/vim-signify'
Plug 'neomake/neomake'
Plug 'myusuf3/numbers.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'easymotion/vim-easymotion'
if using_vim
    Plug 'rosenfeld/conque-term'
    Plug 'vim-scripts/matchit.zip'
endif
call plug#end()

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

if using_vim
    set nocompatible
    filetype plugin on
    filetype indent on
    set ls=2
    set incsearch
    set hlsearch
    syntax on
    set directory=~/.vim/dirs/tmp     " directory to place swap files in
    set backup                        " make backup files
    set backupdir=~/.vim/dirs/backups " where to put backup files
    set undofile                      " persistent undos - undo after you re-open the file
    set undodir=~/.vim/dirs/undos
    set viminfo+=n~/.vim/dirs/viminfo
    if !isdirectory(&backupdir)
        call mkdir(&backupdir, "p")
    endif
    if !isdirectory(&directory)
        call mkdir(&directory, "p")
    endif
    if !isdirectory(&undodir)
        call mkdir(&undodir, "p")
    endif
end

set encoding=utf-8
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set nu
set fillchars+=vert:\ 
set completeopt+=noinsert
set completeopt-=preview
set wildmode=list:longest
set scrolloff=10
set shell=/bin/bash 
set t_Co=256

colorscheme vim-monokai-tasty

ca w!! w !sudo tee "%"

map  f <Plug>(easymotion-bd-f)
nmap F <Plug>(easymotion-overwin-f2)
map tt :tabnew 
map <F3> :NERDTreeToggle<CR>
nmap ,e :Files<CR>
nmap ,g :BTag<CR>
nmap ,wg :execute ":BTag " . expand('<cword>')<CR>
nmap ,G :Tags<CR>
nmap ,wG :execute ":Tags " . expand('<cword>')<CR>
nmap ,f :BLines<CR>
nmap ,wf :execute ":BLines " . expand('<cword>')<CR>
nmap ,F :Lines<CR>
nmap ,wF :execute ":Lines " . expand('<cword>')<CR>
nmap ,c :Commands<CR>
nmap ,D :tab split<CR>:call jedi#goto()<CR>
nmap - <Plug>(choosewin)
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

nnoremap <silent> // :noh<CR>
autocmd BufWritePre *.py :%s/\s\+$//e

au FileType python map <silent> <leader>b Oimport ipdb; ipdb.set_trace()<esc>

let g:tagbar_autofocus = 1

let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

highlight! link NERDTreeFlags NERDTreeDir

let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"
let NERDTreeNodeDelimiter = "\x07"

function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()

autocmd! BufWritePost * Neomake

let g:neomake_python_python_maker = neomake#makers#ft#python#python()
let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
let g:neomake_python_python_maker.exe = 'python3 -m py_compile'
let g:neomake_python_flake8_maker.exe = 'python3 -m flake8'
let g:neomake_virtualtext_current_error = 0

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
            \   'ignore_case': v:true,
            \   'smart_case': v:true,
            \})

let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

let g:jedi#completions_enabled = 0

let g:jedi#goto_command = ',d'
let g:jedi#usages_command = ',o'
let g:jedi#goto_assignments_command = ',a'

let g:choosewin_overlay_enable = 1

let g:signify_vcs_list = ['git', 'hg']

highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

if using_neovim
    let g:yankring_history_dir = '~/.config/nvim/'
    let g:yankring_clipboard_monitor = 0
else
    let g:yankring_history_dir = '~/.vim/dirs/'
endif

let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0

if fancy_symbols_enabled
    let g:webdevicons_enable = 1
    if !exists('g:airline_symbols')
       let g:airline_symbols = {}
    endif
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = '⭠'
    let g:airline_symbols.readonly = '⭤'
    let g:airline_symbols.linenr = '⭡'
else
    let g:webdevicons_enable = 0
endif

if using_neovim
    let custom_configs_path = "~/.config/nvim/custom.vim"
else
    let custom_configs_path = "~/.vim/custom.vim"
endif
if filereadable(expand(custom_configs_path))
  execute "source " . custom_configs_path
endif

hi! link NeomakeError airline_y_inactive_red
