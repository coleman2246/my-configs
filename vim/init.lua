local vim = vim

-- Define the path to vim-plug
local config_path = vim.fn.stdpath('config')
local vim_plug_path = config_path .. '/autoload/plug.vim'

-- Check if vim-plug is installed
local function file_exists(file)
    local stat = vim.loop.fs_stat(file)
    return stat and stat.type == 'file'
end

-- Function to install vim-plug
local function install_vim_plug(path)
    local url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    local command = string.format('curl -fLo %s --create-dirs %s', vim.fn.shellescape(path), url)
    print("Installing Vim-plug...")
    os.execute(command)
end

-- Install vim-plug if not present
local vim_plug_just_installed = false
if not file_exists(vim_plug_path) then
    install_vim_plug(vim_plug_path)
    vim_plug_just_installed = true
end

-- Source the plug.vim file if it was just installed
if vim_plug_just_installed then
    vim.cmd('source ' .. vim.fn.fnameescape(vim_plug_path))
end

-- Initialize vim-plug
local plug_dir = config_path .. '/plugged'
vim.call('plug#begin', plug_dir)

-- Your plugin declarations go here
-- Example:
-- vim.call('plug#', 'tpope/vim-sensible')

local Plug = vim.fn['plug#']
vim.call('plug#end')

Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/IndexedSearch'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug('junegunn/fzf', { ['dir'] = '~/.fzf', ['do'] = './install --all' })
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim'
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
Plug('neoclide/coc.nvim', {['branch'] = 'release'})
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.6' })
Plug 'lambdalisue/vim-suda'

vim.call('plug#end')


-- Set options
vim.opt.encoding = 'utf-8'
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.signcolumn = 'no'
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.completeopt:append('noinsert')
vim.opt.completeopt:remove('preview')
vim.opt.wildmode = 'list:longest'
vim.opt.scrolloff = 10
vim.opt.shell = 'bash'
vim.opt.termguicolors = true -- Assuming t_Co=256 implies 256 colors
vim.opt.ignorecase = true

-- Set colorscheme
vim.cmd('colorscheme vim-monokai-tasty')

-- Key mappings
vim.api.nvim_set_keymap('', 'f', '<Plug>(easymotion-bd-f)', {})
vim.api.nvim_set_keymap('n', 'F', '<Plug>(easymotion-overwin-f2)', {})
vim.api.nvim_set_keymap('', 'tt', ':tabnew<CR>', { noremap = true })
vim.api.nvim_set_keymap('', '<F3>', ':NERDTreeToggle<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', ',e', ':Files<CR>', { noremap = true }) -- Commented out as per original
-- vim.api.nvim_set_keymap('n', ',g', ':BTag<CR>', { noremap = true }) -- Commented out as per original
vim.api.nvim_set_keymap('n', ',e', ':Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ',o', ':Telescope live_grep<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', 'nt', ':let $VIM_DIR=expand("%:p:h")<CR>:tabnew<CR>:terminal<CR>Acd $VIM_DIR<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ',wg', ':execute ":BTag " .. expand("<cword>")<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ',G', ':Tags<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ',wG', ':execute ":Tags " .. expand("<cword>")<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ',f', ':BLines<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ',wf', ':execute ":BLines " .. expand("<cword>")<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ',F', ':Lines<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ',wF', ':execute ":Lines " .. expand("<cword>")<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ',c', ':Commands<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '-', '<Plug>(choosewin)', {})
vim.api.nvim_set_keymap('n', '<C-h>', ':tabprevious<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':tabnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<silent> //', ':noh<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<silent><expr> <CR>', 'pumvisible() ? coc#_select_confirm() : "<C-g>u<CR>"', { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

-- Global variables
vim.g.tagbar_autofocus = 1
vim.g.NERDTreeIgnore = { '\\.pyc$', '\\.pyo$' }
vim.g.WebDevIconsUnicodeDecorateFolderNodes = 1
vim.g.DevIconsEnableFoldersOpenClose = 1

-- Highlight settings
vim.cmd('highlight! link NERDTreeFlags NERDTreeDir')

-- More global variables
vim.g.WebDevIconsNerdTreeBeforeGlyphPadding = ''
vim.g.WebDevIconsUnicodeDecorateFolderNodes = true

-- Define a function in Lua
function NERDTreeRefresh()
    if vim.bo.filetype == 'nerdtree' then
        vim.cmd('silent exe substitute(mapcheck("R"), "<CR>", "", "")')
    end
end

-- Set autocommands
vim.cmd('autocmd BufEnter * lua NERDTreeRefresh()')

-- Additional global variables
vim.g.context_filetype_same_filetypes = {}
vim.g.context_filetype_same_filetypes._ = '_'
vim.g.choosewin_overlay_enable = 0
vim.g.AutoClosePumvisible = { ENTER = '\\<C-Y>', ESC = '\\<ESC>' }
vim.g.yankring_history_dir = vim.fn.stdpath('config') .. '/'
vim.g.yankring_clipboard_monitor = 0
vim.g.airline_powerline_fonts = 0
vim.g.airline_theme = 'bubblegum'
vim.g['airline#extensions#whitespace#enabled'] = 0
vim.g.webdevicons_enable = 0
local custom_configs_path = vim.fn.stdpath('config') .. '/custom.vim'
vim.g.coc_global_extensions = { 'coc-python', 'coc-clangd'}
vim.g.python_highlight_space_errors = 0

-- Source additional configuration if it exists
if vim.fn.filereadable(vim.fn.expand(custom_configs_path)) == 1 then
    vim.cmd('source ' .. custom_configs_path)
end

-- Create custom commands
vim.cmd('command WQ wq')
vim.cmd('command Wq wq')
vim.cmd('command W w')
vim.cmd('command Q q')
