--[[ vim.api.nvim_create_autocmd('VimEnter', {
    command = 'NvimTreeOpen',
}) ]]
vim.keymap.set('n', '<F2>', vim.cmd.NvimTreeToggle, { desc = 'Opens file explorer tree' })
