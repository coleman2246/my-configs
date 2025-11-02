local compile_commands = require("indie.utils.compile_commands")
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Helper: search upward for compile_commands.json
local function find_compile_commands_dir(startpath)
  local path = util.search_ancestors(startpath, function(path)
    local file = util.path.join(path, "compile_commands.json")
    return util.path.is_file(file) and path or nil
  end)
  return path
end

lspconfig.clangd.setup({
  capabilities = capabilities,

  on_new_config = function(new_config, root_dir)
    local cc_dir = find_compile_commands_dir(root_dir)
    if not cc_dir then
        compile_commands.run_setup_script()
    end
    if cc_dir then
      new_config.cmd = {
        "clangd",
        "--compile-commands-dir=" .. cc_dir
      }
    end
  end,

  root_dir = util.root_pattern("compile_commands.json", ".git", "Makefile", "CMakeLists.txt"),
})

