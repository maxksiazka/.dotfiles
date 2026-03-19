-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Open Undotree' })
-- vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open File Explorer' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected Down 1' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected Up 1' })

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move down and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move up and center' })

vim.keymap.set('n', '<leader>h', function()
    vim.lsp.buf.hover()
end, { desc = 'Open LSP hover (same as K)' })

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('x', '<leader>p', '"_dP')

vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

vim.keymap.set('n', '<leader>o', 'o<Esc>o')

vim.keymap.set('i', '<C-c>', '<Esc>')

vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

--vim.keymap.set('n', '<F5>', '<cmd>CMakeRun<CR><C-w><C-w>')

vim.keymap.set('t', '<F9>', '<cmd>q<CR>')
-- CMake Generation & Building
vim.keymap.set('n', '<leader>cg', '<cmd>CMakeGenerate<CR>', { desc = 'CMake: Generate' })
vim.keymap.set('n', '<leader>cb', '<cmd>CMakeBuild<CR>', { desc = 'CMake: Build' })
vim.keymap.set('n', '<leader>cd', '<cmd>CMakeDebug<CR>', { desc = 'CMake: Debug' })

-- Extra handy CMake shortcuts
vim.keymap.set('n', '<leader>cr', '<cmd>CMakeRun<CR>', { desc = 'CMake: Run Executable' })
vim.keymap.set('n', '<leader>cq', '<cmd>CMakeCloseRunner<CR>', { desc = 'CMake: Close Window' })
--vim.keymap.set('t', '<F5>', 'make')
-- vim.keymap.set('n', '<F5>', "<cmd>w<CR><cmd>bel 10split<CR><cmd>let $VIM_DIR=expand('%:p')<CR><C-w><C-w><cmd>terminal make<CR>")
-- vim.api.nvim_create_autocmd('BufEnter', {
--     callback = function()
--         local ft = vim.bo.filetype
--     end,
-- })

-- Setup debug for CMake or Makefile projects
-- vim.api.nvim_create_autocmd('BufEnter', {
--     callback = function()
--         local ft = vim.bo.filetype
--         local buf_path = vim.api.nvim_buf_get_name(0)
--         local dir = vim.fn.finddir('.git', vim.fn.expand '%:p:h' .. ';') -- find .git upwards
--         if dir ~= '' then
--             dir = vim.fn.fnamemodify(dir, ':p:h:h') -- get parent of .git directory
--         else
--             dir = vim.fn.fnamemodify(buf_path, ':p:h') -- fallback to file's directory
--         end
--         local make_exists = vim.fn.filereadable(dir .. '/Makefile') == 1
--         local cmake_exists = vim.fn.filereadable(dir .. '/CMakeLists.txt') == 1
--         if (ft == 'cpp' or ft == 'c') and cmake_exists then
--             vim.keymap.del('n', '<F1>')
--             vim.keymap.set('n', '<F1>', '<cmd>CMakeDebug<CR>', { desc = 'Debug: Start/Continue', buffer = 0 })
--         elseif (ft == 'cpp' or ft == 'c') and make_exists then
--             vim.keymap.del('n', '<F1>')
--             vim.keymap.set('n', '<F1>', function()
--                 local dap = require 'dap'
--                 dap.continue()
--             end, { desc = 'Debug: Start/Continue' })
--         end
--     end,
-- })

-- Toggle Copilot on/off
vim.keymap.set('n', '<leader>cp', function()
    local enabled = vim.g.copilot_enabled
    if enabled == 1 then
        vim.cmd 'Copilot disable'
        print 'Copilot disabled'
    else
        vim.cmd 'Copilot enable'
        print 'Copilot enabled'
    end
end, { desc = 'Toggle Copilot' })
