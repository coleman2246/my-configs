return {
  -- Plugin manager itself
  { "folke/lazy.nvim", version = false },

  -- Mini.nvim — modular plugin suite
  {
    "echasnovski/mini.nvim",
    version = false, -- Always use latest
    config = function()
      -- Load specific modules
      require("mini.ai").setup()           -- Better textobjects
      require("mini.comment").setup()      -- Commenting
      require("mini.surround").setup()     -- Surround editing
      --require("mini.indentscope").setup()        -- Autopairs
      --require("mini.pairs").setup()        -- Autopairs
      --require("mini.statusline").setup()   -- Simple statusline
      --require("mini.tabline").setup()      -- Tabline
      --require("mini.trailspace").setup()   -- Trim whitespace

      -- Optional: nice starter screen
      require("mini.starter").setup({
        evaluate_single = true,
        header = "Welcome to Neovim",
      })

    end,
  },
}

