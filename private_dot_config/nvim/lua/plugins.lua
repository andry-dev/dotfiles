local function file_exists(path)
    local f = io.open(path, "r")
    if f ~= nil then
        f:close()
        return true
    else
        return false
    end
end

local function dev_plugin(path)
    local expanded_path = vim.fn.expand(path)
    if file_exists(expanded_path) then
        return expanded_path
    end

    return nil
end

local globals = require('globals')

return {
    -- Personal plugin for lecture-recording
    -- {
    --     'andry-dev/kyouko.nvim',
    --     -- dir = '~/prj/kyouko.nvim',
    --     -- dev = true,
    --     lazy = true,
    --     cmd = 'Kyouko',
    -- },

    -- Personal plugin for reacting to system events
    {
        'https://git.sr.ht/~anri/system_events.nvim',
        -- dir = '~/prjs/anri/nvim-power-states',
        -- dev = true,
        build = 'cargo build --release',
    },

    -- Experimental plugin for exposing a 9P interface
    {
        'https://git.sr.ht/~anri/9.nvim',
        enabled = false,
        dir = '~/prjs/anri/9.nvim',
        dev = true,
        build = 'cargo build --release',
    },

    {
        "f-person/auto-dark-mode.nvim",
        lazy = false,
        priority = 10000,

        dependencies = {
            -- My colorschemes
            {
                'andry-dev/nofrils',
                -- dir = '~/prjs/anri/nofrils',
                -- dev = true,
                -- lazy = false,
            },

            -- These color schemes are used for :SetupForScreens and :PrettyTheme
            -- I don't personally use them
            { "EdenEast/nightfox.nvim" }
        },

        config = function()
            require('config.themes').setup()
        end
    },


    { 'nvim-lua/plenary.nvim' },

    {
        "williamboman/mason.nvim",
        enabled = vim.g.mason_enabled,
        config = function()
            if vim.g.mason_enabled then
                require('mason').setup()
            end
        end
    },

    {
        "zk-org/zk-nvim",
        config = function()
            require("zk").setup({
                picker = "fzf_lua",
            })
        end,

        dependencies = {
            'ibhagwan/fzf-lua',
        }
    },

    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000, -- needs to be loaded in first
        config = function()
            require('tiny-inline-diagnostic').setup({
                preset = "simple",

                options = {
                    multiple_diag_under_cursor = true,
                    show_all_diags_on_cursorline = true,

                    -- NOTE: Hack to allow diagnostics to fire
                    --       for nvim-lint and similar.
                    overwrite_events = { 'DiagnosticChanged' },

                    multilines = {
                        enabled = true,
                        always_show = true,
                    },
                },


                signs = {
                    diag = "●",
                },
            })
            -- vim.diagnostic.config({ virtual_text = false })
        end
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            'ray-x/lsp_signature.nvim',
            {
                "elixir-tools/elixir-tools.nvim",
                enabled = true,
                version = "*",
                event = { "BufReadPre", "BufNewFile" },
                dependencies = { 'nvim-lua/plenary.nvim' },
            },
            'nvim-java/nvim-java',
            'b0o/SchemaStore.nvim',
            {
                "barreiroleo/ltex_extra.nvim",
                -- branch = "dev",
            },
        },
        config = function()
            require('config.lsp')
        end,
    },

    {
        'chomosuke/typst-preview.nvim',
        ft = 'typst',
        version = '1.*',
        config = function()
            require('typst-preview').setup({})
        end
    },

    {
        'stevearc/conform.nvim',
        config = function()
            require('config.format')
        end,
    },

    {
        'mfussenegger/nvim-lint',
        config = function()
            require('config.linters')
        end,
    },

    {
        'mrcjkb/rustaceanvim',
        lazy = false,
        version = '*',
    },

    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        build = ':TSUpdate',
        dependencies = {
            -- 'nvim-treesitter/nvim-treesitter-textobjects',
            -- 'nvim-treesitter/nvim-treesitter-refactor',
            -- 'romgrk/nvim-treesitter-context',
            'windwp/nvim-ts-autotag',
        },
        config = function()
            require('config.treesitter')
        end
    },

    {
        'danymat/neogen',
        config = function()
            require('neogen').setup {
                enabled = true
            }
        end,
        lazy = true,
        cmd = 'Neogen',
        dependencies = 'nvim-treesitter/nvim-treesitter'
    },

    -- {
    --     'RRethy/vim-illuminate',
    --     dependencies = 'nvim-treesitter/nvim-treesitter',
    -- },

    {
        'nvim-mini/mini.ai',
        version = false,
        opts = {}
    },


    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'williamboman/mason.nvim',
            'jay-babu/mason-nvim-dap.nvim',
            'theHamsta/nvim-dap-virtual-text',
            'mfussenegger/nvim-dap-python',
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
        },
        config = function()
            require('config.dap')
        end,
    },


    -- { 'prabirshrestha/async.vim' },

    {
        'L3MON4D3/LuaSnip',

        build = (function()
            -- Build Step is needed for regex support in snippets.
            -- This step is not supported in many windows environments.
            -- Remove the below condition to re-enable on windows.
            if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                return
            end
            return 'make install_jsregexp'
        end)(),

        dependencies = {
            {
                'rafamadriz/friendly-snippets',
                config = function()
                    require('luasnip.loaders.from_vscode').lazy_load()
                end,
            }
        },

        config = function()
            require('config.snippets')
        end,
    },


    {
        'saghen/blink.cmp',
        lazy = false, -- lazy loading handled internally
        dependencies = {
            'rafamadriz/friendly-snippets',
            'nvim-lua/plenary.nvim',
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },

        version = '*',

        config = function()
            require('config.blink')
        end,
    },

    {
        'ibhagwan/fzf-lua',
        config = function()
            require('fzf-lua').setup({
                winopts = { treesitter = { enabled = false }, },
                previewers = { builtin = { syntax = false, treesitter = false, } },
            })

            require('fzf-lua').register_ui_select()
        end
    },

    {
        'tpope/vim-dispatch',
        lazy = true,
        cmd = { 'Dispatch', 'Make', 'Start' }
    },

    {
        'tpope/vim-fugitive',
    },

    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    },

    {
        'tpope/vim-dadbod',
        dependencies = {
            'kristijanhusak/vim-dadbod-completion',
            'kristijanhusak/vim-dadbod-ui',
        },
    },

    {
        "m4xshen/hardtime.nvim",
        opts = {
            disable_mouse = false,
            max_time = 5000,
        },
        event = "BufEnter"
    },

    {
        'nvim-neotest/neotest',
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "jfpedroza/neotest-elixir",
            'nvim-neotest/neotest-go',
            'nvim-neotest/neotest-python',
            'mrcjkb/rustaceanvim',
        },
        config = function()
            require('neotest').setup({
                adapters = {
                    require('neotest-go'),
                    require('neotest-elixir'),
                    require('neotest-python')({
                        dap = { justMyCode = true },
                    }),
                    require('rustaceanvim.neotest'),
                }
            })
        end
    },

    -- {
    --     'numToStr/Comment.nvim',
    --     config = function()
    --         require('config.comment')
    --     end
    -- },

    {
        'stevearc/oil.nvim',
        config = function()
            require('oil').setup()
        end
    },
}
