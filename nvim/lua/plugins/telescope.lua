return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "junegunn/fzf",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "LukasPietzschmann/telescope-tabs",
    build = "make", -- only needed for telescope-fzf-native
    cond = vim.fn.executable("make") == 1,
  },
  opts = function(_, opts)
    -- Extend or modify Telescope defaults here
    local actions = require("telescope.actions")

    opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
      prompt_prefix = " ",
      selection_caret = " ",
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-q>"] = function(prompt_bufnr)
            actions.send_to_qflist(prompt_bufnr)
            vim.schedule(function()
              vim.cmd("cclose")           -- optional, closes quickfix if open
              vim.cmd("FzfLua quickfix")  -- now opens with proper focus
            end)
        end,
          --["<C-q>"] = actions.send_to_qflist + actions.open_qflist,  -- <Ctrl-q> sends to quickfix
        },
        n = {
          ["<C-q>"] = function(prompt_bufnr)
            actions.send_to_qflist(prompt_bufnr)
            vim.schedule(function()
              vim.cmd("cclose")           -- optional, closes quickfix if open
              vim.cmd("FzfLua quickfix")  -- now opens with proper focus
            end)
        end,
        }
      },
    })
  end
}

