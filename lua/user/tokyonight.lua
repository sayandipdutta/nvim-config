-- Example config in Lua
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = 1
vim.g.tokyonight_italic_comments = 1
vim.g.tokyonight_italic_keywords = 0
vim.g.tokyonight_italic_variables = 0
vim.g.tokyonight_transparent_sidebar = true

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

-- Load the colorscheme
vim.cmd[[colorscheme tokyonight]]
