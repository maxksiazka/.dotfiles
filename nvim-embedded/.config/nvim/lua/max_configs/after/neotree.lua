vim.keymap.set('n', '<F2>', '<cmd>Neotree toggle right<CR>')
-- vim.api.nvim_create_autocmd('BufEnter', {
--     group = vim.api.nvim_create_augroup('NeoTreeInit', { clear = true }),
--     callback = function()
--         local stats = vim.loop.fs_stat(vim.api.nvim_buf_get_name(0))
--         if stats and stats.type == 'directory' then
--             require('neo-tree.command').execute { action = 'show', focus = true }
--             vim.cmd 'Neotree toggle'
--         end
--     end,
-- })
vim.api.nvim_create_autocmd('VimEnter', {
    group = vim.api.nvim_create_augroup('NeoTreeDynamicPos', { clear = true }),
    callback = function()
        local arg = vim.fn.argv(0)
        if arg ~= '' and vim.fn.isdirectory(arg) == 1 then
            -- Change CWD to the folder
            vim.cmd('cd ' .. arg)
            -- Open Neo-tree in the CURRENT window (replaces the empty buffer)
            require('neo-tree.command').execute {
                action = 'show',
                position = 'current',
                dir = arg,
            }
        end
    end,
})
