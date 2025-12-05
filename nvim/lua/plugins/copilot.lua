return {
    "zbirenbaum/copilot.lua",
    requires = {
        "copilotlsp-nvim/copilot-lsp",
        init = function()
            vim.g.copilot_node_debounce = 500
        end,
    },
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            copilot_node_command = vim.g.node_host_prog,
            suggestion = {
                enabled = true,
                auto_trigger = true,  -- automatically show suggestions
                debounce = 75,
                keymap = {
                    accept = "<C-s>",    -- accept the suggestion
                    next = "<C-l>",      -- next suggestion
                    prev = "<C-h>",      -- previous suggestion
                    dismiss = "<C-c>",
                },
            },
            filetypes = {
                ["*"] = true,
            },
            panel = { enabled = false },  -- optional, disable side panel
        })
    end,
}
