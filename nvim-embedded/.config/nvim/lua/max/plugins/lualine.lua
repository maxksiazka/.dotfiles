return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
        return {
        options = {
            theme = "tomorrow_night",
            globalstatus = true,
        },
        extensions = { "neo-tree", "lazy" },
        }
    end,
}
