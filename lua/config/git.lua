vim.pack.add({
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/dlyongemallo/diffview.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/pwntester/octo.nvim", },
}, { confirm = false, load = true })

require("gitsigns").setup()
require("diffview").setup()
require("octo").setup({
    picker = "snacks",
    enable_builtin = true,
})

