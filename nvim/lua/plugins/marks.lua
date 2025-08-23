return {
  "chentoast/marks.nvim",
  config = function()
    require("marks").setup({
      -- Basic options
      default_mappings = true,       -- Enable default keymaps
      --builtin_marks = { ".", "<", ">", "^" }, -- Show these builtin marks
      cyclic = true,                 -- Cycle through marks
      refresh_interval = 250,        -- Refresh marks and signs frequency (ms)
      sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
      excluded_filetypes = {},       -- Filetypes to exclude marks in
    })
  end,
}

