-- Inject Neorg
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
}

local treesitter = require 'nvim-treesitter.configs'

treesitter.setup {
    ensure_installed = "maintained",

    highlight = {
        enable = false,
        use_languagetree = true,
    },

    incremental_selection = {
        enable = false,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm"
        }
    },

    indent = {
        enable = false
    },

    --[[
    context_commentstring = {
        enable = true
    },
    --]]

    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = {
                    cpp = "{ @class.inner }",
                }, 
                ["at"] = "@tag.outer",
                ["it"] = "@tag.inner",
                ["p"] = "@parameter.inner",
                ["ib"] = "@block.inner",
                ["ab"] = "@block.outer",
            }
        },

        swap = {
            enable = true,
            swap_next = {["<leader>a"] = "@parameter.inner"},
            swap_previous = {["<leader>A"] = "@parameter.inner"}
        },

        move = {
            enable = true,
            goto_next_start = {
                ["]f"] = "@function.outer",
                ["]]"] = "@class.outer",
                ["]p"] = "@parameter.outer",
                ["]c"] = "@call.outer",
            },
            goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[["] = "@class.outer",
                ["[p"] = "@parameter.outer",
                ["[c"] = "@call.outer",
            },
        },

        lsp_interop = {
            enable = true,
            peek_definition_code = {
                ["df"] = "@function.outer",
                ["dF"] = "@class.outer",
            }
        },

    },

    refactor = {
        enable = true,

        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "<Leader>tr"
            }
        }
    },

    playground = {
        enable = true,
    }

    --tree_docs = {enable = true}
}
