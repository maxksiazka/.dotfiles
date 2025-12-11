return {
    'numToStr/Comment.nvim',
    opts = {
        ignore = '^$',
        toggler = {
            line = '<leader>cc',
            block = '<leader>bc',
        },
        opleader = {
            -- line type comment
            line = '<leader>c',
            -- block type comment
            block = '<leader>b',
        },
    },
}
