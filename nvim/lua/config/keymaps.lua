local map = vim.keymap.set

-- nvim
map('n', '<silent> //', ':noh<CR>', { noremap = true, silent = true })
map('n', '<leader>dt', ':diffthis<CR>', { noremap = true, silent = true })
map('n', '<leader>do', ':diffoff!<CR>', { noremap = true, silent = true })
map("n", "<leader>ln", ":cnext<CR>")
map("n", "<leader>lp", ":cprev<CR>")
map("n", "<leader>lo", ":copen<CR>")
map("n", "<leader>lc", ":cclose<CR>")
map("n", "<leader>ss", ":set spell! spell?<CR>")


vim.api.nvim_create_user_command("CopyRelPath", function()
    local path = vim.fn.expand("%") -- relative path to current file
    vim.fn.setreg("+", path)        -- copy to system clipboard
    vim.fn.setreg('"', path)        -- copy to system clipboard
    vim.cmd('OSCYankRegister "')  -- explicitly trigger OSCYank
end, {})
map("n", "ycf", "<cmd>CopyRelPath<CR>", { desc = "Copy relative path" })

vim.api.nvim_create_user_command("CopyAbsPath", function()
    local path = vim.fn.expand("%:p") -- relative path to current file
    vim.fn.setreg("+", path)        -- copy to system clipboard
    vim.fn.setreg('"', path)        -- copy to system clipboard
    vim.cmd('OSCYankRegister "')  -- explicitly trigger OSCYank
end, {})
map("n", "yca", "<cmd>CopyAbsPath<CR>", { desc = "Copy absolute path" })





-- oil
map("n", "tn", "<CMD>Oil<CR>")
map("n", "tt", ":tabnew | lua require(\"oil\").open()<CR>",{}) 


-- easymotion
vim.keymap.set({'n', 'x', 'o'}, 'f', '<Plug>(easymotion-bd-f)', { noremap = false, silent = true })

-- window picker
map('n', '-', function()
  local picked_window_id = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(picked_window_id)
end, { desc = 'Pick a window' })


-- fzf-lua
--map('n', ',e', ':FZF<CR>', { noremap = true }) 
map('n', ',e', ':FzfLua files<CR>', { noremap = true }) 
map('n', ',i', ':FzfLua quickfix<CR>', { noremap = true }) 



-- telescope
map('n', ',o', ":lua require('telescope').extensions.live_grep_args.live_grep_args({default_text = \"-tc --no-ignore --glob !*test* --glob !*build* \"})<CR>",{ noremap = true })
map('n', '<Leader>,o', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",{ noremap = true })
map('n', ',u', ':Telescope buffers<CR>', { noremap = true })
map('n', ',a', ':Telescope telescope-tabs list_tabs<CR>', { noremap = true })
map('n', ',h', ':Telescope marks<CR>', { noremap = true })
map('n', ',t', ':Telescope current_buffer_fuzzy_find<CR>', { noremap = true, silent = true})

-- nvim-lspconfig
map("n", "gd", vim.lsp.buf.definition, opts)           -- Go to definition
map("n", "gD", vim.lsp.buf.declaration, opts)          -- Go to declaration
map("n", "gi", vim.lsp.buf.implementation, opts)       -- Go to implementation
map("n", "gr", vim.lsp.buf.references, opts)           -- List references
map("n", "K", vim.lsp.buf.hover, opts)

--marks nvim
map("n", "mm", require("marks").toggle, { noremap = true, silent = true, desc = "Toggle mark" })
map("n", "mn", require("marks").next, { noremap = true, silent = true, desc = "Next mark" })
map("n", "mN", require("marks").prev, { noremap = true, silent = true, desc = "Prev mark" })
map("n", "ml", ":MarksQFListBuf<CR>", { noremap = true, silent = true, desc = "List Marks in Buffer" })


-- vimwiki
vim.keymap.set("n", "<leader>wS", function()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row, row, false, {
    "",
    string.rep("-", 80),
    ""
  })
end, { noremap = true, silent = true })

--   map("n", "<Leader>oo", ":ObsidianOpen<CR>",         { desc = "Open Vault" })
map("n", "<Leader>w<Leader>w", ":ObsidianToday<CR>",        { desc = "Open Daily Note" })
map("n", "<Leader>wf", ":ObsidianFollowLink<CR>",  { desc = "Follow WikiLink" })
map("n", "<Leader>wb", ":ObsidianBacklinks<CR>",    { desc = "Show Backlinks" })
map("n", "<Leader>ws", ":ObsidianQuickSwitch<CR>", { desc = "Quick Switch Notes" })
