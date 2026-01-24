return {
    "nvim-lualine/lualine.nvim",
    opts = {
        options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "|", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            always_show_tabline = true,
            globalstatus = false,
            refresh = {
                statusline = 100,
                tabline = 100,
                winbar = 100,
            },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { {"filename", path = 1} },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {
        --   lualine_a = {
        --       {
        --           'buffers',
        --           mode = 2,                 -- shows buffer numbers + filenames
        --           max_length = vim.o.columns * 2 / 3,  -- prevent overflow
        --           buffers_color = {
        --               active = 'lualine_a_normal',
        --               inactive = 'lualine_b_normal',
        --           },
        --           symbols = {
        --               modified = '●',          -- shows a dot if buffer is modified
        --               alternate_file = '#',    -- optional
        --               directory = '',        -- folder icon
        --           },
        --           show_filename_only = false, -- full path
        --           show_modified_status = true,
        --           show_tabs_only = true,
        --       }
        --   },
        --   lualine_z = {'tabs'},  -- shows actual Neovim tabs
        },

        winbar = {},
        inactive_winbar = {},
        extensions = {},
    },
}
