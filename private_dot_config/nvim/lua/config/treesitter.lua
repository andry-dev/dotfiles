local treesitter = require 'nvim-treesitter.configs'

treesitter.setup {
    ensure_installed = { "vimdoc", "markdown", "bash", "c", "cpp", "cmake", "css", "cuda", "dockerfile", "html", "elixir", "erlang", "fennel",
    "glsl", "go", "html", "http", "java", "javascript", "jsdoc", "json", "json5", "latex", "kotlin", "lua", "llvm",
    "ninja", "nix", "php", "python", "rust", "scala", "solidity", "scss", "toml", "typescript", "vim", "vue", "yaml" },

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

    -- textobjects = {
    --     select = {
    --         enable = true,
    --         lookahead = true,
    --         keymaps = {
    --             ["af"] = "@function.outer",
    --             ["if"] = "@function.inner",
    --             ["ac"] = "@class.outer",
    --             ["ic"] = {
    --                 cpp = "{ @class.inner }",
    --             },
    --             ["at"] = "@tag.outer",
    --             ["it"] = "@tag.inner",
    --             ["p"] = "@parameter.inner",
    --             ["ib"] = "@block.inner",
    --             ["ab"] = "@block.outer",
    --         }
    --     },
    --
    --     swap = {
    --         enable = true,
    --         swap_next = {["<leader>a"] = "@parameter.inner"},
    --         swap_previous = {["<leader>A"] = "@parameter.inner"}
    --     },
    --
    --     move = {
    --         enable = true,
    --         goto_next_start = {
    --             ["]f"] = "@function.outer",
    --             ["]]"] = "@class.outer",
    --             ["]p"] = "@parameter.outer",
    --             ["]c"] = "@call.outer",
    --         },
    --         goto_previous_start = {
    --             ["[f"] = "@function.outer",
    --             ["[["] = "@class.outer",
    --             ["[p"] = "@parameter.outer",
    --             ["[c"] = "@call.outer",
    --         },
    --     },
    --
    --     lsp_interop = {
    --         enable = true,
    --         peek_definition_code = {
    --             ["<Leader>df"] = "@function.outer",
    --             ["<Leader>dF"] = "@class.outer",
    --         }
    --     },
    -- },

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
        enable = false,
    },

    --tree_docs = {enable = true}
}

require('nvim-ts-autotag').setup({})


vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
