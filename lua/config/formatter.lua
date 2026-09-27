vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim" },
}, { confirm = false })

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    json = { "jq" },
    go = { "gofmt" },
    bash = { "shfmt" },
    typescript = { "eslint_d", "prettier", "prettierd", stop_after_first = true  },
    typescriptreact = { "eslint_d", "prettier", "prettierd", stop_after_first = true  },
    vue = { "eslint_d", "prettier" },
    yaml = { "yq" },
    python = { "ruff_format", "ruff_organize_imports" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
  },

  format_on_save = function(bufnr)
    local results = vim.fs.find(
        { '.noformat' },
        { type = 'file', upward = true, path = vim.fn.expand('%:p:h') }
    )
    if #results > 0 then
        return
    elseif vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 2000, lsp_format = "fallback" }
  end,
})


vim.api.nvim_create_user_command("ToggleFormat", function(args)
  local disabled = (vim.b.disable_autoformat or vim.g.disable_autoformat)
  if args.bang and not disabled then
    vim.b.disable_autoformat = true
    return
  end
  vim.b.disable_autoformat = not disabled
  vim.g.disable_autoformat = not disabled
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function(args)
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
end, {
  desc = "enable autoformat-on-save",
})
