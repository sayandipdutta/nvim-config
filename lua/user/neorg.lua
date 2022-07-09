require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.norg.qol.toc"] = {},
        ["core.norg.completion"] = {
              config = {
                engine = "nvim-cmp" -- We current support nvim-compe and nvim-cmp only
              }
            },
        ["core.norg.journal"] = {},
        ["core.export"] = {},
        ["core.norg.concealer"] = {},
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    work = "~/notes/work",
                    home = "~/notes/home",
                }
            }
        },
    ["core.export.markdown"] = {
      config = { -- Note that this table is optional and doesn't need to be provided
        -- Configuration here
      }
    },
    ["core.integrations.treesitter"] = {
      config = { -- Note that this table is optional and doesn't need to be provided
        norg = {
          url = "https://github.com/nvim-neorg/tree-sitter-norg",
          files = { "src/parser.c", "src/scanner.cc" },
          branch = "main",
        },
        norg_meta = {
          url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
          files = { "src/parser.c" },
          branch = "main",
        },
      }
    }
    }
}
