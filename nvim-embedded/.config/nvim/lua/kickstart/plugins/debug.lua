return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',
    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        -- 1. Setup Mason to automatically install the codelldb adapter
        require('mason-nvim-dap').setup {
            automatic_installation = true,
            ensure_installed = { 'codelldb' },
            handlers = {},
        }

        -- 2. Basic Debugging Keymaps
        vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
        vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
        vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
        vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
        vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
        vim.keymap.set('n', '<leader>B', function()
            dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end, { desc = 'Debug: Set Conditional Breakpoint' })

        vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '❓', texthl = '', linehl = '', numhl = '' })
        vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = 'Visual', numhl = 'Visual' })

        -- 3. Setup DAP UI
        dapui.setup()

        -- Automatically open/close the DAP UI when debugging starts/stops
        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        -- 4. Standard Desktop C/C++ Configuration
        local cpp_config = {
            {
                name = 'Launch executable',
                type = 'codelldb',
                request = 'launch',
                program = function()
                    -- Prompts you for the path to your compiled app
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                -- Renders output in the integrated REPL/Console
                console = 'integratedTerminal',
            },
        }

        dap.configurations.cpp = cpp_config
        dap.configurations.c = cpp_config
    end,
}
