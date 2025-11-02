local map = vim.keymap.set

-- compile_commands setup
local compile_commands = require("indie.utils.compile_commands")
map("n", "<leader>fc", compile_commands.run_setup_script, { noremap = true, silent = true })

