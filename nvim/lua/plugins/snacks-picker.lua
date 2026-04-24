vim.keymap.set("n", "<Leader>fb", function()
    vim.cmd("packadd snacks.nvim")
    require("snacks.picker").buffers()
end)

vim.keymap.set("n", "<Leader>ff", function()
    vim.cmd("packadd snacks.nvim")
    require("snacks.picker").git_files()
end)

vim.keymap.set("n", "<Leader>fg", function()
    vim.cmd("packadd snacks.nvim")
    require("snacks.picker").grep()
end)

vim.keymap.set("n", "<Leader>fk", function()
    vim.cmd("packadd snacks.nvim")
    require("snacks.picker").keymaps()
end)
