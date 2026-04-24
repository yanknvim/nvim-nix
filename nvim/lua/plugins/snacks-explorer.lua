vim.keymap.set("n", "<Leader><Leader>", function()
    vim.cmd("packadd snacks.nvim")
    require("snacks.explorer").open()
end)
