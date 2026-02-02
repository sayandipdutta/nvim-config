require("config.options")
require("config.keymaps")
require("config.autocmd")

require("config.picker") -- contains explorer, and lazygit
require("config.treesitter")
require("config.mason")
require("config.lsp")
require("config.formatter")
require("config.linter")
require("config.dap")
require("config.completion")
require("config.tabline")
require("config.ui")
require("config.explorer") -- only mini.files
require("config.sessions")
require("config.trouble")
require("config.web")

-- Setup lazy.nvim
-- require("lazy").setup({
--     spec = {
--         -- add your plugins here
--         {
--             "zenbones-theme/zenbones.nvim",
--             -- Optionally install Lush. Allows for more configuration or extending the colorscheme
--             -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
--             -- In Vim, compat mode is turned on as Lush only works in Neovim.
--             dependencies = "rktjmp/lush.nvim",
--             lazy = false,
--             priority = 1000,
--             -- you can set set configuration options here
--             config = function()
--                 -- vim.g.zenbones_darken_comments = 45
--                 vim.cmd.colorscheme('neobones')
--             end
--         }
--     },
-- ,
--
--     -- Configure any other settings here. See the documentation for more details.
--     -- colorscheme that will be used when installing plugins.
--     install = { colorscheme = { "default" } },
--     -- automatically check for plugin updates
--     checker = { enabled = false },
-- }
-- )

vim.keymap.set({ 'n', 't' }, '', -- this is <C-/>
    function()
        Snacks.terminal()
    end, { desc = "Toggle Terminal" })
-- vim.keymap.set({'n', 't'}, '<C-w>t', function() Snacks.terminal.terminal() end, {desc = "Toggle Terminal" })
-- vim.keymap.set('t', '<C-w>h', '<C-\\><C-n><C-w>h')
-- vim.keymap.set('t', '<C-w>l', '<C-\\><C-n><C-w>l')
-- vim.keymap.set('t', '<C-w>j', '<C-\\><C-n><C-w>j')
-- vim.keymap.set('t', '<C-w>k', '<C-\\><C-n><C-w>k')

vim.keymap.set('n', 'gx', function() vim.fn.system({ 'wslview', vim.fn.expand('<cfile>') }) end)

function AutoSplit(term)
    local splitcmd = function()
        local height = vim.api.nvim_win_get_height(0) * 3
        local width = vim.api.nvim_win_get_width(0)

        if height > width then
            vim.cmd("split")
        else
            vim.cmd("vsplit")
        end
    end
    if term then
        return function()
            splitcmd()
            vim.cmd("term")
        end
    end
    splitcmd()
end

vim.keymap.set({ 'i', 'v', 'n' }, '<C-w>a', AutoSplit, { desc = "Automatically split in optimal direction" })
vim.keymap.set('t', '<C-w>a', AutoSplit(true), { desc = "Automatically split in optimal direction" })

vim.lsp.inlay_hint.enable()
vim.lsp.config['basedpyright'] = {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },

    root_markers = { 'pyproject.toml', 'uv.lock', 'pylock.toml', '.python-version' },
    settings = {
        basedpyright = {
            analysis = {
                diagnosticMode = "workspace",
                inlayHints = {
                    callArgumentNames = true,
                }
            }
        }
    }
}
vim.lsp.enable("basedpyright", false)

-- vim.lsp.config["mojo_ls"] = {
--     cmd = { 'mojo-lsp-server' },
--     filetypes = { 'mojo' },
--     root_dir = function(fname)
--         return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
--     end,
--     single_file_support = true,
-- }
--
-- vim.lsp.enable("mojo_ls")

vim.lsp.config('ty', {
    cmd = { 'ty', 'server' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'uv.lock', 'pylock.toml', '.python-version' },
    settings = {
        ty = {
            diagnosticMode = "workspace",
            experimental = {
                rename = true,
                autoImport = true,
            }
        }
    }
})
vim.lsp.config("ruff", {
    cmd = { 'ruff', 'server' },
    root_markers = { 'pyproject.toml', 'uv.lock', 'pylock.toml', '.python-version' },
    filetypes = { 'python' },
    init_options = {
        settings = {
            configurationPreference = "filesystemFirst",
            fixAll = true,
            organizeImports = true,
            lint = {
                enable = true,
                preview = true,
            },
            format = {
                preview = true,
            },
        },
    },
})

vim.lsp.enable("ruff")
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { desc = "[C]ode [F]ormat" })

vim.lsp.enable("pyrefly", false)
vim.lsp.enable("ty")

local function create_diagnostic_toggler()
    local hidden = false
    local state = {
        local_hidden = hidden,
        global_hidden = hidden,
    }

    --- Toggle diagnostic ghost lines in buffer or globally.
    ---
    ---@param bufnr integer? If bufnr is 0, toggle diagnostics in local buffer
    ---                      if omitted, toggle diagnostic globally. Otherwise ignore.
    local toggle_diagnostic = function(bufnr)
        if bufnr == nil then
            state.global_hidden = not state.global_hidden
            hidden = state.global_hidden
        elseif bufnr == 0 then
            state.local_hidden = not state.local_hidden
            hidden = state.local_hidden
        else
            return
        end
        if not hidden then
            vim.diagnostic.hide(nil, bufnr)
        else
            vim.diagnostic.show(nil, bufnr)
        end
    end
    return toggle_diagnostic
end

local toggle_diagnostic = create_diagnostic_toggler()

vim.keymap.set('n', '<leader>ud', function()
    toggle_diagnostic(0)
end, { desc = "Toggle Diagnostics Buffer" })
vim.keymap.set('n', '<leader>uD', toggle_diagnostic, { desc = "Toggle Diagnostics Global" })
vim.keymap.set('n', 'gd', function()
    vim.lsp.buf.definition()
end, { desc = "Toggle Diagnostics" })

vim.keymap.set('n', 'gK', function()
    local new_config = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })

-- what was this about??
vim.diagnostic.handlers.loclist = {
    show = function(_, _, _, opts)
        -- Generally don't want it to open on every update
        opts.loclist.open = opts.loclist.open or false
        local winid = vim.api.nvim_get_current_win()
        vim.diagnostic.setloclist(opts.loclist)
        vim.api.nvim_set_current_win(winid)
    end
}
-- vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, { desc = "Signature [H]elp" })
-- ^ this is handled by C-S
