vim.pack.add({
  { src = "https://github.com/akinsho/bufferline.nvim" },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
  { src = "https://github.com/Bekaboo/dropbar.nvim" },
}, { confirm = false })

require("bufferline").setup({
  options = {
    mode = "tabs",
    always_show_bufferline = false,
  },
})

require("lualine").setup({ options = { theme = "moonfly" }})

local dropbar_api = require('dropbar.api')
vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
