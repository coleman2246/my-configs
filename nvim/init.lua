require("config.lazy")
require("config.options")
require("config.global_vars")
require("config.keymaps")
require("config.custom_commands")

if vim.env.INDIE_LAPTOP then
    require("indie.keymaps")
    require("indie.nvim-lspconfig")
end

