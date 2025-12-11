return {
    'kkoomen/vim-doge',
    -- 1. **Crucial:** The 'build' command runs the installation script
    --    which compiles language-specific documentation generators.
    build = ':call doge#install()',

    -- 2. Optional: Define filetypes to load the plugin for.
    ft = { 'python', 'javascript', 'php', 'c', 'cpp', 'java', 'go', 'lua' },

    -- 3. Configuration using the 'config' function
    config = function()
        -- Get the global options table (vim.g is the standard way to set g: variables)
        local g = vim.g

        ----------------------------------------------------------------------
        -- **Doge Mapping Defaults**
        ----------------------------------------------------------------------

        -- The key that triggers documentation generation (default is <Leader>d)

        -- Enable/disable built-in mappings for generation (<Leader>d) and jumping (<Tab>/<S-Tab>)
        g.doge_enable_mappings = 0
        g.doge_comment_jump_modes = 'normal'

        -- Generate comment for current line and delete the default setting
        vim.keymap.del('n', '<leader>d')
        vim.keymap.set('n', '<Leader>dc', '<Plug>(doge-generate)')

        -- Interactive mode comment todo-jumping
        vim.keymap.set('n', '<TAB>', '<Plug>(doge-comment-jump-forward)')
        vim.keymap.set('n', '<S-TAB>', '<Plug>(doge-comment-jump-backward)')
        vim.keymap.set('x', '<TAB>', '<Plug>(doge-comment-jump-forward)')
        vim.keymap.set('x', '<S-TAB>', '<Plug>(doge-comment-jump-backward)')

        ----------------------------------------------------------------------
        -- **Doge Core Defaults**
        ----------------------------------------------------------------------

        -- Set the default standard for new docstrings if not specified per-filetype
        -- Default is 'docblock', which is a generic standard.
        g.doge_doc_standard = 'docblock'

        -- Specifies the type of docstring syntax to use for new files
        -- Default is 'new' (use the 'new' docblock style)
        g.doge_doc_standard_new = 'new'

        -- Should Doge remove the existing docblock before generating a new one?
        -- Default is 1 (yes)
        g.doge_doc_standard_remove = 1

        -- Should Doge respect the existing indentation?
        -- Default is 1 (yes)
        g.doge_doc_standard_indent = 1

        ----------------------------------------------------------------------
        -- **Per-Filetype Defaults (Examples)**
        ----------------------------------------------------------------------

        -- Setting an explicit standard for a filetype overrides the global doge_doc_standard

        -- Python: Default is 'docblock' (generic style), but 'numpy' and 'google' are common.
        g.doge_doc_standard_python = 'docblock'

        -- Javascript: Default is 'jsdoc'
        g.doge_doc_standard_javascript = 'jsdoc'

        -- Java: Default is 'javadoc'
        g.doge_doc_standard_java = 'javadoc'

        -- Go: Default is 'godoc'
        g.doge_doc_standard_go = 'godoc'

        -- PHP: Default is 'docblock'
        g.doge_doc_standard_php = 'docblock'

        -- C/C++: Default is 'doxygen'
        g.doge_doc_standard_c = 'doxygen_javadoc'
        g.doge_doc_standard_cpp = 'doxygen_javadoc'

        g.doge_doxygen_settings = {
            char = '\\',
            brief = 1,
            params = 1,
            return_val = 1,
        }
    end,
}
