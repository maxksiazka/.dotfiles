function ClassCppHandler()
    local keys = vim.api.nvim_replace_termcodes(':lua ClassCpp("")<Left><Left>', false, false, true)
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.api.nvim_feedkeys(keys, 'n', {})
end
function ClassCpp(string1)
    vim.cmd('silent !touch ' .. string1 .. '.h')
    vim.cmd('silent !touch ' .. string1 .. '.cpp')
    vim.cmd('silent !echo \'\\#include "' .. string1 .. '.h"\' >> ' .. string1 .. '.cpp')
    local string2 = string.upper(string1) .. '_H_'
    vim.cmd("silent !echo '\\#ifndef " .. string2 .. "' >> " .. string1 .. '.h')
    vim.cmd("silent !echo '\\#define " .. string2 .. "' >> " .. string1 .. '.h')
    vim.cmd('silent !echo class ' .. string1 .. '{ >> ' .. string1 .. '.h')
    vim.cmd('silent !echo } >> ' .. string1 .. '.h')
    vim.cmd("silent !echo '\\#endif //" .. string2 .. "' >> " .. string1 .. '.h')
end
function PressEnter()
    local keys = vim.api.nvim_replace_termcodes('<CR>', true, false, true)
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.api.nvim_feedkeys(keys, 'n', {})
end
function GitCommit()
    vim.cmd('!git add .', { silent = true })
    local keys = vim.api.nvim_replace_termcodes(':!git commit -m ""<Left>', false, false, true)
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.api.nvim_feedkeys(keys, 'n', {})
end
vim.cmd('Copilot disable')
