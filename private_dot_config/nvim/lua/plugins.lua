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
    {
        'andry-dev/kyouko.nvim',
        -- dir = '~/prj/kyouko.nvim',
        -- dev = true,
        lazy = true,
        cmd = 'Kyouko',
    },

    -- -- My colorscheme
    -- {
    --     'andry-dev/nofrils',
    --     -- dir = '~/prj/nofrils',
    --     -- dev = true,
    --     lazy = false,
    -- },

    {
        "f-person/auto-dark-mode.nvim",
        lazy = false,
        priority = 10000,

        dependencies = {
            'andry-dev/nofrils',

            -- These color schemes are used for :SetupForScreens and :PrettyTheme
            -- I don't personally use them
            'navarasu/onedark.nvim',
        },

        config = function()
            require('config.themes').setup()
        end
    },


    { 'nvim-lua/plenary.nvim' },

    {
        "williamboman/mason.nvim",
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
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,

        opts = {
            bigfile = { enabled = true },
            image = {
                enabled = false,
            }
        },
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
                version = "*",
                event = { "BufReadPre", "BufNewFile" },
                dependencies = { 'nvim-lua/plenary.nvim' },
            },
            {
                'mfussenegger/nvim-jdtls',
                ft = 'java'
            },
            -- {
            --     'folke/trouble.nvim',
            --     cmd = 'Trouble'
            -- },
            -- {
            --     'simrat39/symbols-outline.nvim',
            --     cmd = 'SymbolsOutline'
            -- },
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


    -- {
    --     'creativenull/efmls-configs-nvim',
    --     version = '^v1',
    --     dependencies = { 'neovim/nvim-lspconfig' },
    -- },

    {
        'https://github.com/mfussenegger/nvim-lint',
        dependencies = { 'neovim/nvim-lspconfig' },
    },

    {
        'mrcjkb/rustaceanvim',
        lazy = false,
        version = '^6',
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {
            -- 'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-refactor',
            -- 'romgrk/nvim-treesitter-context',
            'windwp/nvim-ts-autotag',
        },
        config = function()
            require('config.treesitter')
        end
    },

    {
        'echasnovski/mini.ai',
        version = false,
        opts = {}
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
        dependencies = 'nvim-treesitter'
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
            'stevearc/conform.nvim',
            'nvim-neotest/nvim-nio',
        },
        config = function()
            require('config.dap')
        end,
    },


    { 'prabirshrestha/async.vim' },

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

    -- {
    --     -- 'hrsh7th/nvim-cmp',
    --     -- 'yioneko/nvim-cmp',
    --     -- branch = 'perf-up',
    --     'iguanacucumber/magazine.nvim',
    --     name = 'nvim-cmp',
    --     enabled = (vim.g.completion_framework == globals.CompletionFramework.NvimCmp),
    --     dependencies = {
    --         'L3MON4D3/LuaSnip',
    --         'saadparwaiz1/cmp_luasnip',
    --         'hrsh7th/cmp-buffer',
    --         'hrsh7th/cmp-nvim-lsp',
    --         'hrsh7th/cmp-nvim-lsp-signature-help',
    --         'petertriho/cmp-git',
    --         'hrsh7th/cmp-path',
    --         'rcarriga/cmp-dap',
    --         'kristijanhusak/vim-dadbod-completion',
    --         'folke/lazydev.nvim',
    --     },
    --     config = function()
    --         require('config.cmp')
    --     end
    -- },

    {
        'saghen/blink.cmp',
        enabled = (vim.g.completion_framework == globals.CompletionFramework.Blink),
        lazy = false, -- lazy loading handled internally
        dependencies = {
            'rafamadriz/friendly-snippets',
            'folke/lazydev.nvim',
            'nvim-lua/plenary.nvim',
        },

        version = '*',

        config = function()
            require('config.blink')
        end,
    },

    {
        'ibhagwan/fzf-lua',
        opts = {
            winopts = { treesitter = { enabled = false }, },
            previewers = { builtin = { syntax = false, treesitter = false, } },
        }
    },

    -- {
    --     'cdelledonne/vim-cmake',
    --     lazy = true,
    --     ft = 'cmake'
    -- },

    {
        'tpope/vim-dispatch',
        lazy = true,
        cmd = { 'Dispatch', 'Make', 'Start' }
    },

    {
        'tpope/vim-fugitive',
    },

    {
        'tpope/vim-rhubarb',
        lazy = true,
        cmd = 'GBrowse'
    },

    {
        'junegunn/gv.vim',
        lazy = true,
        cmd = 'GV'
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
        -- dependencies = { "MunifTanjim/nui.nvim" },
        opts = {},
        event = "BufEnter"
    },

    {
        'nvim-neotest/neotest',
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "jfpedroza/neotest-elixir",
            'nvim-neotest/neotest-go',
            'nvim-neotest/neotest-python',
        },
        lazy = true,
        cmd = { 'NeotestFileRun', 'NeotestRun', 'NeotestSummary' },
        -- ft = {'go'},
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

    -- { 'vim-test/vim-test' },
    --
    -- {
    --     'dhruvasagar/vim-testify',
    --     lazy = true,
    --     ft = { 'vim' },
    --     cmd = { 'TestifyFile' }
    -- },

    {
        'numToStr/Comment.nvim',
        config = function()
            require('config.comment')
        end
    },

    {
        'stevearc/oil.nvim',
        config = function()
            require('oil').setup()
        end
    },

    {
        'tami5/sqlite.lua',
        lazy = true
    },
}
