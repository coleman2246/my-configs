return {
    "iamcco/markdown-preview.nvim",
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
    ft = { "markdown" },
    config = function()
        vim.g.mkdp_port = "8080"
        vim.g.mkdp_auto_start = 0
        vim.g.mkdp_auto_close = 1
        vim.g.mkdp_refresh_slow = 0
        vim.g.mkdp_command_for_global = 0
        vim.g.mkdp_open_to_the_world = 1
        vim.g.mkdp_echo_preview_url = 0
        vim.g.mkdp_page_title = "Markdown Preview"
        vim.g.mkdp_preview_options = {
            disable_sync_scroll = 0,
            hide_yaml_meta = 1,
            disable_filename = 0,
        }
    end,
}

