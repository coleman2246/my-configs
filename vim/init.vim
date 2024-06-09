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
Plug 'Shougo/deoplete.nvim'

"if using_neovim && vim_plug_just_installed
"    Plug 'Shougo/deoplete.nvim', {'do': ':autocmd VimEnter * UpdateRemotePlugins'}
"else
"    Plug 'Shougo/deoplete.nvim'
"endif

Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'Shougo/context_filetype.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'sheerun/vim-polyglot'
Plug 'lilydjwg/colorizer'
Plug 't9md/vim-choosewin'
Plug 'valloric/MatchTagAlways'
Plug 'myusuf3/numbers.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'easymotion/vim-easymotion'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
Plug 'lambdalisue/vim-suda'


call plug#end()

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

set encoding=utf-8
set expandtab
set tabstop=4
set signcolumn=no
set softtabstop=4
set shiftwidth=4
set nu
set completeopt+=noinsert
set completeopt-=preview
set wildmode=list:longest
set scrolloff=10
set shell=bash
set t_Co=256
set ignorecase

colorscheme vim-monokai-tasty

map  f <Plug>(easymotion-bd-f)
nmap F <Plug>(easymotion-overwin-f2)
map tt :tabnew 
map <F3> :NERDTreeToggle<CR>
"nmap ,e :Files<CR>
"nmap ,g :BTag<CR>
nmap ,e :Telescope find_files<CR>
nmap ,o :Telescope live_grep<CR>


nmap nt :let $VIM_DIR=expand('%:p:h')<CR>:tabnew<CR>:terminal<CR>Acd $VIM_DIR<CR>
nmap ,wg :execute ":BTag " . expand('<cword>')<CR>
nmap ,G :Tags<CR>
nmap ,wG :execute ":Tags " . expand('<cword>')<CR>
nmap ,f :BLines<CR>
nmap ,wf :execute ":BLines " . expand('<cword>')<CR>
nmap ,F :Lines<CR>
nmap ,wF :execute ":Lines " . expand('<cword>')<CR>
nmap ,c :Commands<CR>
nmap - <Plug>(choosewin)
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <silent> // :noh<CR>
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
tnoremap <Esc> <C-\><C-n>


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


let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'
let g:choosewin_overlay_enable = 0
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}
let g:yankring_history_dir = '~/.config/nvim/'
let g:yankring_clipboard_monitor = 0
let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0
let g:webdevicons_enable = 0
let custom_configs_path = "~/.config/nvim/custom.vim"
let g:coc_global_extensions = ['coc-python', 'coc-clangd']
let g:python_highlight_space_errors = 0

if filereadable(expand(custom_configs_path))
  execute "source " . custom_configs_path
endif

:command WQ wq
:command Wq wq
:command W w
:command Q q
