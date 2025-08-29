local map = vim.keymap.set

-- nvim
map('n', '<silent> //', ':noh<CR>', { noremap = true, silent = true })
map('n', '<leader>dt', ':diffthis<CR>', { noremap = true, silent = true })
map('n', '<leader>do', ':diffoff!<CR>', { noremap = true, silent = true })
map("n", "<leader>ln", ":cnext<CR>")
map("n", "<leader>lp", ":cprev<CR>")
map("n", "<leader>lo", ":copen<CR>")
map("n", "<leader>lc", ":cclose<CR>")


vim.api.nvim_create_user_command("CopyRelPath", function()
  local path = vim.fn.expand("%") -- relative path to current file
  vim.fn.setreg("+", path)        -- copy to system clipboard
  print("Copied to clipboard: " .. path)
end, {})
map("n", "ycf", "<cmd>CopyRelPath<CR>", { desc = "Copy relative path" })


-- oil
map("n", "tn", "<CMD>Oil<CR>")
map("n", "tt", ":tabnew | lua require(\"oil\").open()<CR>",{}) 


-- easymotion
map({'n', 'x', 'v', 'o', 's'}, 'f', '<Plug>(easymotion-bd-f)', {noremap = true})


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
map('n', ',o', ":lua require('telescope').extensions.live_grep_args.live_grep_args({default_text = \"--glob !test* --glob !build* \"})<CR>",{ noremap = true })
map('n', ',u', ':Telescope buffers<CR>', { noremap = true })
map('n', ',a', ':Telescope telescope-tabs list_tabs<CR>', { noremap = true })
--map('n', ',i', ':Telescope marks<CR>', { noremap = true })

-- nvim-lspconfig
map("n", "gd", vim.lsp.buf.definition, opts)           -- Go to definition
map("n", "gD", vim.lsp.buf.declaration, opts)          -- Go to declaration
map("n", "gi", vim.lsp.buf.implementation, opts)       -- Go to implementation
map("n", "gr", vim.lsp.buf.references, opts)           -- List references
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<leader>le", ":lua vim.diagnostic.setqflist()<CR>", opts)

--marks nvim
map("n", "mm", require("marks").toggle, { noremap = true, silent = true, desc = "Toggle mark" })
map("n", "mn", require("marks").next, { noremap = true, silent = true, desc = "Next mark" })
map("n", "mp", require("marks").prev, { noremap = true, silent = true, desc = "Prev mark" })
map("n", "ml", ":MarksQFListBuf<CR>", { noremap = true, silent = true, desc = "List Marks in Buffer" })



