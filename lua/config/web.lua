vim.pack.add(
    { { src = "https://github.com/mistweaverco/kulala.nvim" } }
-- ,{ confirm = false }
)
require("kulala").setup({
    global_keymaps = false,
    global_keymaps_prefix = "<leader>R",
    kulala_keymaps_prefix = "",
})
