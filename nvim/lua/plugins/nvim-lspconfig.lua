return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    local util = require("lspconfig.util")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Safer capabilities setup
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    -- Helper: search upward for compile_commands.json
    local function find_compile_commands_dir(startpath)
      local path = util.search_ancestors(startpath, function(path)
        local file = util.path.join(path, "compile_commands.json")
        return util.path.is_file(file) and path or nil
      end)
      return path
    end

    -- --- C/C++ ---
    lspconfig.clangd.setup({
      capabilities = capabilities,
      on_new_config = function(new_config, root_dir)
        local cc_dir = find_compile_commands_dir(root_dir)
        if cc_dir then
          new_config.cmd = { "clangd", "--compile-commands-dir=" .. cc_dir }
        end
      end,
      root_dir = util.root_pattern(
        "compile_commands.json",
        ".git",
        "Makefile",
        "CMakeLists.txt"
      ),
    })

    -- --- Python (Pyright) ---
    lspconfig.pyright.setup({
      capabilities = capabilities,
      root_dir = util.root_pattern(
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        ".git"
      ),
      settings = {
        python = {
          pythonPath = (function()
            local venv = os.getenv("VIRTUAL_ENV")
            if venv and #venv > 0 then
              return venv .. "/bin/python"
            end
            return vim.fn.exepath("python3") or "python3"
          end)(),
        },
        pyright = {
          disableOrganizeImports = true,
        },
        analysis = {
          typeCheckingMode = "basic",
          autoImportCompletions = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
        },
      },
    })

    -- --- Python (Ruff) ---
    lspconfig.ruff.setup({
      capabilities = capabilities,
      on_attach = function(client, _)
        -- disable hover so Pyright handles it
        client.server_capabilities.hoverProvider = false
      end,
      root_dir = util.root_pattern("pyproject.toml", ".ruff.toml", ".git"),
      init_options = {
        settings = {
          args = {},
        },
      },
    })

    -- --- Rust (rust-analyzer) ---
    -- Uncomment if needed
    -- lspconfig.rust_analyzer.setup({
    --   capabilities = capabilities,
    --   root_dir = util.root_pattern("Cargo.toml", ".git"),
    --   settings = {
    --     ["rust-analyzer"] = {
    --       cargo = {
    --         allFeatures = true,
    --       },
    --       checkOnSave = {
    --         command = "clippy", -- use cargo clippy for better diagnostics
    --       },
    --     },
    --   },
    -- })
  end,
}

