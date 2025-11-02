-- ~/.config/nvim/lua/custom_bindings.lua

local M = {}
function open_file(file_path)

    -- Check if main.c is already open in any tab or window
    for tabnr = 1, vim.fn.tabpagenr('$') do
        for winnr = 1, vim.fn.tabpagewinnr(tabnr, '$') do
            local bufnr = vim.fn.tabpagebuflist(tabnr)[winnr]

            if vim.fn.bufname(bufnr) == file_path then
                vim.cmd(tabnr .. "tabnext")
                vim.cmd(winnr .. "wincmd w")
                return
            end
        end
    end

    -- If not already open, open main.c in a new tab
    vim.cmd("tabnew " .. file_path)
end


function M.copy_file_to_sysclip()
    local file_path =  vim.fn.fnamemodify(vim.fn.expand('%:p'), ':~:.')  -- Full path of the current file
    file_path = file_path :gsub('\\', '/')

    if file_path ~= '' then
        -- Use system command based on OS to copy to clipboard
        if vim.fn.has('mac') == 1 then
            -- macOS
            os.execute('echo ' .. file_path .. ' | pbcopy')
        elseif vim.fn.has('unix') == 1 then
            -- Unix-like (Linux)
            os.execute('echo ' .. file_path .. ' | xclip -selection clipboard')
        elseif vim.fn.has('win32') == 1 then
            -- Windows
            os.execute('echo ' .. file_path .. ' | clip')
        else
            print('Clipboard copying not supported on this OS.')
        end
        print('Copied path to clipboard: ' .. file_path)
    else
        print('No file associated with buffer.')
    end
end


local function get_lines_around_cursor(num_lines)
    local line_nr = vim.api.nvim_win_get_cursor(0)[1]
    local start_line = math.max(0, line_nr - num_lines - 1)
    local end_line = line_nr + num_lines
    return vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
end

return M
