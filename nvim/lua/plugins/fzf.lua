return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require('fzf-lua').setup({
        {"telescope",winopts={preview={default="bat"}}}
    })
  end,
}

