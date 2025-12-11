return { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
        {
            '<leader>f',
            function()
                require('conform').format { async = true, lsp_fallback = false }
            end,
            mode = '',
            desc = '[F]ormat buffer',
        },
    },
    opts = {
        notify_on_error = false,
        formatters_by_ft = {
            lua = { 'stylua' },
            c = { 'clang_format' },
            cpp = { 'clang_format' },
            h = { 'clang_format' },
            hpp = { 'clang_format' },
            -- Conform can also run multiple formatters sequentially
            python = { 'ruff' },
            --
            -- You can use a sub-list to tell conform to run *until* a formatter
            -- is found.
            -- javascript = { { "prettierd", "prettier" } },
        },
        formatters = {
            clang_format = {
                prepend_args = {
                    '--style={BasedOnStyle: Microsoft, IndentWidth: 4, TabWidth: 4, UseTab: Never, ColumnLimit: 80, BreakBeforeBraces: Attach, PointerAlignment: Left}',
                    -- , Completion: {ArgumentLists: OpenDelimiter}}
                },
            },
        },
    },
}
