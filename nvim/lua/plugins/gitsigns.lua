vim.defer_fn(function ()
    vim.cmd("packadd gitsigns.nvim")
    require("gitsigns").setup {}
end, 0)
