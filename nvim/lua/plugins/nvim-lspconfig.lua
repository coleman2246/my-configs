-- Common on_attach function
local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true, buffer=bufnr }
  local map = vim.keymap.set

  -- Go-to / Navigation
  map('n', 'gd', function() vim.lsp.buf.definition() end, opts)
  map('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
  map('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
  map('n', 'gr', function() vim.lsp.buf.references() end, opts)
  map('n', '<leader>gt', function() vim.lsp.buf.type_definition() end, opts)

  -- Hover / Signature help
  map('n', 'K', function() vim.lsp.buf.hover() end, opts)
  map('n', '<C-k>', function() vim.lsp.buf.signature_help() end, opts)

  -- Code actions / Refactor
  map('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
  map('v', '<leader>ca', function() vim.lsp.buf.range_code_action() end, opts)
  map('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)

  -- Diagnostics
  map('n', '<leader>e', function() vim.diagnostic.open_float() end, opts)
  map('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
  map('n', ']d', function() vim.diagnostic.goto_next() end, opts)
  map('n', '<leader>q', function() vim.diagnostic.setloclist() end, opts)
end


return {
    "neovim/nvim-lspconfig",
    config = function()
        local util = require("lspconfig.util")
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }

        vim.lsp.config('pyrefly', {
           name = "pyrefly",
           cmd = { "pyrefly", "lsp" },
           capabilities = capabilities,
           filetypes = { "python" },
           root_markers = { "pyproject.toml", ".git", vim.uv.cwd() },
           on_attach = on_attach
           --    print("pyright LSP attached to buffer " .. bufnr)
           --end,
       })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "python",
            callback = function()
                local attached = false
                for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
                    if c.name == "py" then
                        attached = true
                        break
                    end
                end
                if not attached then
                    vim.lsp.enable('pyrefly')
                end
            end,
        })

        vim.lsp.config('clangd', {
            name = "clangd",
            cmd = { "/usr/bin/clangd" },
            capabilities = capabilities,
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
            root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" },
            on_init = function(client, init_result)
                if init_result.offsetEncoding then
                    client.offset_encoding = init_result.offsetEncoding
                end
            end,
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                vim.api.nvim_buf_create_user_command(bufnr, 'LspClangdSwitchSourceHeader', function()
                    switch_source_header(bufnr, client)
                end, { desc = 'Switch between source/header' })

                vim.api.nvim_buf_create_user_command(bufnr, 'LspClangdShowSymbolInfo', function()
                    symbol_info(bufnr, client)
                end, { desc = 'Show symbol info' })
            end,
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "c",
            callback = function()
                local attached = false
                for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
                    if c.name == "c" then
                        attached = true
                        break
                    end
                end
                if not attached then
                    vim.lsp.enable('clangd')
                end
            end,
        })


        vim.lsp.config('rust_analyzer', {
            name = "rust_analyzer",
            cmd = { "rust-analyzer"},
            capabilities = capabilities,
            filetypes = {"rust"},
            root_markers = { "Cargo.toml", ".git" },
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                     -- *** Auto-format on save ***
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ async = false })
                    end,
                })
            end,
 
        })


        vim.api.nvim_create_autocmd("FileType", {
            pattern = "rust",
            callback = function()
                local attached = false
                for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
                    if c.name == "rust-analyzer" then
                        attached = true
                        break
                    end
                end
                if not attached then
                    vim.lsp.enable("rust_analyzer")
                end
            end,
        })
    end,
}
