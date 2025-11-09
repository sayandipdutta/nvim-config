vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" },
}, { confirm = false })

require("snacks").setup({
    dashboard = { enabled = false },
    scratch = { enabled = false },
    terminal = { enabled = true },
    scroll = { enabled = false },
    indent = { enabled = false },
    words = { enabled = true },
    lazygit = { enabled = true },
    picker = {
        prompt = "󰍉 ",
        sources = {
            grep = {
                hidden = true,
            },
            explorer = {
                layout = {
                    layout = { preset = "left" },
                },
                include = {
                    ".github",
                },
                exclude = {
                    ".git",
                },
            },
        },
        icons = {
            ui = {
                selected = "+ ",
            },
        },
        layouts = {
            default = {
                layout = {
                    box = "horizontal",
                    width = 0.8,
                    min_width = 120,
                    height = 0.8,
                    {
                        box = "vertical",
                        border = "vpad",
                        title = "{title} {live} {flags}",
                        { win = "input", height = 1,     border = { "", "", "", "", "", "", "", " " } },
                        { win = "list",  border = "vpad" },
                    },
                    {
                        win = "preview",
                        title = "{preview}",
                        title_pos = "center",
                        border = "vpad",
                        width = 0.5,
                    },
                },
            },
            sidebar = {
                layout = {
                    backdrop = false,
                    width = 40,
                    max_width = 80,
                    height = 0,
                    position = "left",
                    border = "none",
                    box = "vertical",
                    {
                        win = "input",
                        height = 1,
                        border = { " ", " ", " ", " ", "", "", "", " " },
                        title = "{title} {live} {flags}",
                        title_pos = "center",
                    },
                    { win = "list", border = "none" },
                    {
                        win = "preview",
                    },
                },
            },
        },
        formatters = {
            file = {
                truncate = 80,
            },
        },
        win = {
            input = {
                keys = {
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    ["<C-o>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
                    ["<c-D>"] = { "inspect", mode = { "n", "i" } },
                    ["<c-F>"] = { "toggle_follow", mode = { "i", "n" } },
                    ["<c-H>"] = { "toggle_hidden", mode = { "i", "n" } },
                    ["<c-I>"] = { "toggle_ignored", mode = { "i", "n" } },
                    ["<c-M>"] = { "toggle_maximize", mode = { "i", "n" } },
                    ["<M-C-P>"] = { "toggle_preview", mode = { "i", "n" } },
                },
            },
            list = {
                keys = {
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    ["<C-o>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
                },
            },
        },
    },
})

local toggle_explorer = function(cwd)
    return function()
        local explorer = Snacks.picker.get({ source = "explorer" })[1]
        if explorer == nil or explorer:is_focused() then
            Snacks.picker.explorer(cwd and { cwd = cwd } or {})
        else
            explorer:focus()
        end
    end
end

vim.keymap.set("n", "<leader><leader>", Snacks.picker.smart, { desc = "Smart Find Files" })
vim.keymap.set("n", "<leader>/", Snacks.picker.grep, { desc = "Grep" })
-- git
vim.keymap.set("n", "<leader>gs", Snacks.picker.git_status, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gl", Snacks.picker.git_log, { desc = "Git Log" })
vim.keymap.set("n", "<leader>gb", Snacks.picker.git_branches, { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gL", Snacks.picker.git_log_line, { desc = "Git Log Line" })
vim.keymap.set("n", "<leader>gS", Snacks.picker.git_stash, { desc = "Git Stash" })
vim.keymap.set("n", "<leader>gd", Snacks.picker.git_diff, { desc = "Git Diff (Hunks)" })
vim.keymap.set("n", "<leader>gf", Snacks.picker.git_log_file, { desc = "Git Log File" })
vim.keymap.set("n", "<leader>,", Snacks.picker.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Toggle Lazygit" })
-- find
vim.keymap.set("n", "<leader>ff", Snacks.picker.files, { desc = "find files" })
vim.keymap.set("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
    { desc = "find config" })
vim.keymap.set("n", "<leader>fr", Snacks.picker.recent, { desc = "find recent" })
vim.keymap.set("n", "<leader>fp", Snacks.picker.projects, { desc = "find projects" })
vim.keymap.set("n", "<leader>fg", Snacks.picker.git_files, { desc = "find git files" })

-- search
vim.keymap.set("n", "<leader>sk", Snacks.picker.keymaps, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sn", Snacks.picker.notifications, { desc = "Notifications" })
vim.keymap.set("n", "<leader>sw", Snacks.picker.grep_word, { desc = "Search Word" })
vim.keymap.set("n", "<leader>sc", Snacks.picker.commands, { desc = "Search Commands" })
vim.keymap.set("n", "<leader>sd", Snacks.picker.lsp_symbols, { desc = "Search Symbols" })
vim.keymap.set("n", "<leader>sD", Snacks.picker.lsp_workspace_symbols, { desc = "Search Workspace Symbols" })
vim.keymap.set("n", '<leader>s"', Snacks.picker.registers, { desc = "Registers" })
vim.keymap.set("n", '<leader>s/', Snacks.picker.search_history, { desc = "Search History" })
vim.keymap.set("n", "<leader>sa", Snacks.picker.autocmds, { desc = "Autocmds" })
vim.keymap.set("n", "<leader>sb", Snacks.picker.lines, { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>sB", Snacks.picker.grep_buffers, { desc = "grep buffers" })
vim.keymap.set("n", "<leader>s:", Snacks.picker.command_history, { desc = "Command History" })
vim.keymap.set("n", "<leader>sd", Snacks.picker.diagnostics, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sD", Snacks.picker.diagnostics_buffer, { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>sh", Snacks.picker.help, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>ss", Snacks.picker.lsp_symbols, { desc = "Lsp Symbols" })
vim.keymap.set("n", "<leader>sS", Snacks.picker.lsp_workspace_symbols, { desc = "Lsp Workspace Symbols" })
--                 { "<leader>sH", Snacks.picker.highlights, desc = "Highlights" },
vim.keymap.set("n", "<leader>si", Snacks.picker.icons, { desc = "Icons" })
--                 { "<leader>sj", Snacks.picker.jumps, desc = "Jumps" },
vim.keymap.set("n", "<leader>sl", Snacks.picker.loclist, { desc = "Location List" })
--                 { "<leader>sm", Snacks.picker.marks, desc = "Marks" },
vim.keymap.set("n", "<leader>sm", Snacks.picker.man, { desc = "Man Pages" })
--                 { "<leader>sp", Snacks.picker.lazy, desc = "Search for Plugin Spec" },
vim.keymap.set("n", "<leader>sq", Snacks.picker.qflist, { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>sr", Snacks.picker.lsp_references, { desc = "Lsp References" })
--                 { "<leader>sR", Snacks.picker.resume, desc = "Resume" },
vim.keymap.set("n", "<leader>su", Snacks.picker.undo, { desc = "Undo History" })
-- terminal
vim.keymap.set("n", "<leader>e", toggle_explorer(), { desc = "Explorer Snacks (root)" })
vim.keymap.set("n", "<leader>E", toggle_explorer(vim.fn.getcwd()), { desc = "Explorer Snacks (cwd)" })
vim.keymap.set("n", "<leader>E", toggle_explorer(vim.fn.getcwd()), { desc = "Explorer Snacks (cwd)" })
vim.keymap.set("n", "<leader>tt", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
vim.keymap.set("n", "<leader>tn", Snacks.terminal.open, { desc = "New Terminal" })
-- ui
vim.keymap.set("n", "<leader>uC", Snacks.picker.colorschemes, { desc = "Colorschemes" })
-- lsp
--{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
--{ "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
--{ "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
--{ "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
--{ "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
--{"<C-w>t", function() Snacks.terminal.open() end, mode = { 'n', 't' }, desc = "New Terminal" },




vim.keymap.set("n", "[r", function()
    Snacks.words.jump(-vim.v.count1)
end, { desc = "Jum to Previous reference", remap = true })
vim.keymap.set("n", "]r", function()
    Snacks.words.jump(vim.v.count1)
end, { desc = "Jum to Next reference", remap = true })


---- LSP
--{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
--{ "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
--{ "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
--{ "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
--{ "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
--{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
--{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
--{"<C-w>t", function() Snacks.terminal.open() end, mode = { 'n', 't' }, desc = "New Terminal" },
