return {
  "neovim/nvim-lspconfig",
  config = function()
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

    -- --- C/C++ (existing) ---
    lspconfig.clangd.setup({
      capabilities = capabilities,
      on_new_config = function(new_config, root_dir)
        local cc_dir = find_compile_commands_dir(root_dir)
        if cc_dir then
          new_config.cmd = { "clangd", "--compile-commands-dir=" .. cc_dir }
        end
      end,
      root_dir = util.root_pattern("compile_commands.json", ".git", "Makefile", "CMakeLists.txt"),
    })

    -- --- Python: Pyright ---
    -- npm i -g pyright   (or)   pipx install pyright
    lspconfig.pyright.setup({
      capabilities = capabilities,
      root_dir = util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git"),
      settings = {
        python = {
          -- If you use virtualenvs, this helps Pyright resolve interpreter/stdlib
          pythonPath = (function()
            -- try to prefer venv in project if present
            local venv = os.getenv("VIRTUAL_ENV")
            if venv and #venv > 0 then
              return venv .. "/bin/python"
            end
            return vim.fn.exepath("python3") or "python3"
          end)(),
        },
        pyright = {
          disableOrganizeImports = true, -- let Ruff handle imports if you enable ruff_lsp below
        },
        analysis = {
          typeCheckingMode = "basic",   -- "off" | "basic" | "strict"
          autoImportCompletions = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly", -- speed on large repos; try "workspace" if you prefer
        },
      },
    })

    -- --- Python: Ruff (optional but recommended) ---
    -- pipx install ruff-lsp  (requires 'ruff' installed too)
    lspconfig.ruff.setup({
      capabilities = capabilities,
      -- Run Ruff only for linting/quickfix; avoid duplicate hover/defs with Pyright
      on_attach = function(client, _)
        -- Disable hover so Pyright provides it
        client.server_capabilities.hoverProvider = false
      end,
      root_dir = util.root_pattern("pyproject.toml", ".ruff.toml", ".git"),
      init_options = {
        settings = {
          args = {}, -- e.g. { "--extend-select", "UP" }
        },
      },
    })
  end,
}

