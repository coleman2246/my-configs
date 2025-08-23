return {
  "lewis6991/gitsigns.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  commit = "7010000889bfb6c26065e0b0f7f1e6aa9163edd9",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      current_line_blame_opts = {
        delay = 1000,
        virt_text_pos = "eol",
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = vim.api.nvim_buf_set_keymap


        -- Keymaps for toggling blame, etc (optional)
        map(bufnr, "n", "<leader>gb", "<cmd>Gitsigns blame<CR>", { noremap = true, silent = true })
        map(bufnr, "n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", { noremap = true, silent = true })
        map(bufnr, "n", "<leader>gD", "<cmd>Gitsigns toggle_deleted<CR>", { noremap = true, silent = true })
      end,
    })
  end,
}

