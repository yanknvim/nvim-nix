vim.fn["skkeleton#config"]({
    globalDictionaries = { vim.g.skk_jisyo },
    eggLikeNewline = true,
})

vim.keymap.set({ "i", "c" }, [[<C-j>]], [[<Plug>(skkeleton-enable)]], { noremap = false })

