vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.files" },
}, { confirm = false, load = true })

require("mini.files").setup({})

vim.keymap.set("n", "<leader>f", function()
    MiniFiles.open()
end, { desc = "Open mini-files" })
