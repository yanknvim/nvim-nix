vim.defer_fn(function ()
    vim.cmd("packadd reactive.nvim")
    require("reactive").setup {
        builtin = {
            cursorline = true,
            cursor = true,
        }
    }
end, 0)
