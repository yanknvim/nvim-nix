vim.keymap.set({"n", "x", "o"}, "s", function()
    vim.cmd("packadd flash.nvim")
    require("flash").jump {}
end)
