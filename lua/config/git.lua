vim.pack.add({
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/dlyongemallo/diffview.nvim" }
}, { confirm = false, load = true })

require("gitsigns").setup()
require("diffview").setup()

