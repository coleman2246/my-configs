return { 
  "ojroques/vim-oscyank",
  config = function()
    -- Should be accompanied by a setting clipboard in tmux.conf, also see
    -- https://github.com/ojroques/vim-oscyank#the-plugin-does-not-work-with-tmux
    vim.g.oscyank_term = "default"
    vim.g.oscyank_max_length = 0  -- unlimited
    -- Below autocmd is for copying to OSC52 for any yank operation,
    -- see https://github.com/ojroques/vim-oscyank#copying-from-a-register
    vim.api.nvim_create_autocmd("TextYankPost", {
      pattern = "*",
      callback = function()
        if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
          vim.cmd('OSCYankRegister "')
        end
      end,
    })
  end,
}
