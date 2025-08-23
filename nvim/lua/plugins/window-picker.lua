return {
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    lazy = true,
    event = "VeryLazy", -- or change to suit your setup
    version = "2.*",
    config = function()
      require("window-picker").setup({
        hint = "floating-big-letter",
        selection_chars = "AOEUIDHTNSFGCYP>BWXKJ",
        include_current_win = true,
        show_prompt = false,
        fg_color = "#ededed",
        current_win_hl_color = "#ff1100",
        other_win_hl_color = "#44cc41",
        highlights = {
            enabled = true,
            statusline = {
                focused = {
                    fg = '#ededed',
                    bg = '#e35e4f',
                    bold = true,
                },
                unfocused = {
                    fg = '#ededed',
                    bg = '#44cc41',
                    bold = true,
                },
            },
            winbar = {
                focused = {
                    fg = '#ededed',
                    bg = '#e35e4f',
                    bold = true,
                },
                unfocused = {
                    fg = '#ededed',
                    bg = '#44cc41',
                    bold = true,
                },
            },
        },
      })
    end,
  }
}

