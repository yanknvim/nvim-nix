vim.keymap.set("n", "<Leader>fb", function()
    require("snacks.picker").buffers()
end)

vim.keymap.set("n", "<Leader>ff", function()
    require("snacks.picker").git_files()
end)

vim.keymap.set("n", "<Leader>fg", function()
    require("snacks.picker").grep()
end)

vim.keymap.set("n", "<Leader>fk", function()
    require("snacks.picker").keymaps()
end)
