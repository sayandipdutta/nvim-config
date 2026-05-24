-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.cmd("source ~/.vimrc")

vim.loop = vim.uv or vim.loop

local vim_info_dir = vim.fn.getcwd() .. "/.vim"
vim.g.vim_info_dir = vim_info_dir

if vim.loop.fs_stat(vim_info_dir) == nil and vim.loop.fs_access(vim.fn.getcwd(), "W") then
    vim.fn.mkdir(vim_info_dir)
end
vim.opt.shadafile = vim_info_dir .. "/main.shada"

for _, name in ipairs({ "state" }) do
    local folder = vim_info_dir .. "/" .. name
    if vim.loop.fs_stat(folder) == nil and vim.loop.fs_access(vim_info_dir, "W") then
        vim.fn.mkdir(folder)
    end

    vim.env[("XDG_%s_HOME"):format(name:upper())] = folder
end

vim.filetype.add({
    pattern = {
        [".*/.github/workflows/.*%.ya?ml"] = "yaml.ghaction",
        [".*/git/config"] = "gitconfig",
        [".gitmodules"] = "gitconfig",
        [".*/.?ssh/config.*"] = "sshconfig",
    },
})

vim.filetype.add({
    extension = { mdx = "markdown" },
})

vim.o.statuscolumn = "%l%s"
vim.o.signcolumn = "yes:1"
-- vim.o.laststatus = 3
-- vim.o.scrolloff = 3

-- vim.o.foldlevel = 99
-- vim.o.foldmethod = "indent"
-- vim.o.foldtext = ""
vim.o.exrc = true

vim.o.autoindent = true
vim.o.smartindent = true
vim.o.cindent = true

--

-- vim.o.backup = false
vim.o.completeopt = "menu,menuone,popup,fuzzy,preview"
vim.o.confirm = true
vim.o.cursorline = true
vim.o.cursorlineopt = "both"

vim.o.number = true
vim.o.relativenumber = true

vim.o.laststatus = 0
vim.o.ruler = false
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- vim.o.colorcolumn = "80"
vim.o.wrap = false
vim.o.synmaxcol = 300

vim.o.selectmode = "mouse"

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4

vim.o.splitbelow = true
vim.o.splitright = true

vim.opt.clipboard:append { "unnamedplus" }

vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldmethod = 'expr'
vim.opt.foldlevelstart = 99
vim.opt.undofile = true
-- Comment this line
local home_dir = os.getenv("HOME") or os.getenv("USERPROFILE")
vim.opt.undodir = home_dir .. "/.vim/undodir"
-- vim.o.winborder = "rounded"

-- global vars
vim.g.mapleader = " "
vim.g.localmapleader = " "



-- python
local python3_prog = vim.fs.joinpath(vim.env.HOME, "projects/neovim-venv/venv/bin/python")
if vim.uv.fs_stat(python3_prog) then
    vim.g.python3_host_prog = python3_prog
end



-- vim.g.clipboard = {
--     name = 'WslClipboard',
--     copy = {
--         ['+'] = 'clip.exe',
--         ['*'] = 'clip.exe',
--     },
--     paste = {
--         ['+'] =
--         'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--         ['*'] =
--         'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--     },
--     cache_enabled = 0,
-- }

local in_wsl = os.getenv("WSL_DISTRO_NAME") ~= nil

if in_wsl then
    vim.g.clipboard = {
        name = "win32yank-wsl",
        copy = {
            ["+"] = "win32yank.exe -i --crlf",
            ["*"] = "win32yank.exe -i --crlf",
        },
        paste = {
            ["+"] = "win32yank.exe -o --lf",
            ["*"] = "win32yank.exe -o --lf",
        },
        cache_enabled = 0,
    }
end   

