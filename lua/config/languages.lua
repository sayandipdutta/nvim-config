return {
    {
        treesitter = { "java" },
        mason = { "jdtls", "java-debug-adapter", "java-test", "google-java-format" },
        lsp = { "jdtls" },
    },
    {
        treesitter = { "lua" },
        mason = { "stylua", "lua-language-server" },
        lsp = { "lua_ls" },
    },
    {
        treesitter = { "go" },
        mason = { "gopls" },
        lsp = { "gopls" },
    },
    {
        treesitter = { "json" },
        mason = { "jq", "jsonlint" },
    },
    {
        treesitter = { "sql" },
        mason = { "sqlls", "sqruff" },
        lsp = { "sqlls" },
    },
    {
        treesitter = { "yaml" },
        mason = { "yq", "yamllint", "yaml-language-server", "actionlint" },
        lsp = { "yamlls" },
    },
    {
        treesitter = { "javascript", "typescript", "tsx", "html", "css" },
        mason = { "vtsls", "eslint_d", "prettier", "prettierd" },
        lsp = { "vtsls" },
    },
    {
        treesitter = { "bash" },
        mason = { "shellcheck", "shfmt", "bash-language-server" },
        lsp = { "bashls" },
    },
    {
        treesitter = { "rust" },
        mason = { "rust-analyzer" },
        lsp = { "rust_analyzer" },
    },
    {
        treesitter = { "vue" },
        mason = { "vue-language-server" },
        lsp = { "vue_ls" },
    },
    {
        treesitter = { "python" },
        mason = { "basedpyright", "pyright", "ruff", "ty", "pyrefly" },
        lsp = { "ty" },
    },
    {
        mason = { "copilot-language-server" },
        lsp = { "copilot" },
    },
    {
        mason = { "tailwindcss-language-server" },
        lsp = { "tailwindcss" },
    },
    {
        mason = { "gh" },
    },
}
