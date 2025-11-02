local M = {}

function M.run_setup_script()
  local config_path = vim.fn.stdpath("config")
  local python_script = config_path .. "/lua/indie/utils/setup_compile_commands.py"

  local output = vim.fn.system({ "python3", python_script })

  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to run setup_compile_commands.py", vim.log.levels.ERROR)
    return
  end

  vim.notify(output)
end

return M

