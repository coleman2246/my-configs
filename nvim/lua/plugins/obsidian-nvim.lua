return {
    -- Obsidian.nvim setup
    {
        "epwalsh/obsidian.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("obsidian").setup({
                dir = "~/vimwiki",           -- your wiki folder
                completion = {
                    nvim_cmp = true,         -- enable completion using nvim-cmp
                },
                daily_notes = {
                    folder = "diary",        -- where to store daily notes
                    date_format = "%Y-%m-%d",
                },
                templates = {
                    subdir = "templates",     -- template folder
                    date_format = "%Y-%m-%d",
                    time_format = "%H:%M"
                },
                ui = {
                    enable = true
                },
                mappings = {
                    -- Overrides 'gf' to work on markdown/wiki links
                    ["gf"] = {
                        action = function()
                            return require("obsidian").util.gf_passthrough()
                        end,
                        opts = { noremap = false, expr = true, buffer = true },
                    },
                    -- Toggle checkboxes
                    ["<leader>ch"] = {
                        action = function()
                            return require("obsidian").util.toggle_checkbox()
                        end,
                        opts = { buffer = true },
                    },
                    -- Smart action depending on context (follow link or toggle checkbox)
                    ["<cr>"] = {
                        action = function()
                            return require("obsidian").util.smart_action()
                        end,
                        opts = { buffer = true, expr = true },
                    },
                }
            })
        end,
    }
}

