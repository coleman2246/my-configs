return {
  {
    "patstockwell/vim-monokai-tasty",
    lazy = false,
    priority = 1000,
    config = function()
        local hl = vim.api.nvim_set_hl
        vim.cmd.colorscheme("vim-monokai-tasty")
        vim.o.termguicolors = true

        hl(0, "GitSignsAddLn",    { bg = "#2c3b27" })  -- dark greenish
        hl(0, "GitSignsChangeLn", { bg = "#5c4530" })  -- warm brownish
        hl(0, "GitSignsDeleteLn", { bg = "#4b1f1f" })  -- deep reddish

        -- Tweaking diff highlights to better fit Monokai Tasty
        hl(0, "DiffAdd",    { fg = "#a6e22e", bg = "#2c3b27" })  -- bright green on dark green
        hl(0, "DiffChange", { fg = "#fd971f", bg = "#5c4530" })  -- orange on brown
        hl(0, "DiffDelete", { fg = "#f92672", bg = "#4b1f1f" })  -- pink/red on dark red
        hl(0, "DiffText",   { fg = "#f8f8f2", bg = "#6c4a4a" })  -- light text on muted red
    end,
  },
}

