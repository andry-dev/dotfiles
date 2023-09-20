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

return {
    {
        'andry-dev/kyouko.nvim',
        -- dir = '~/prj/kyouko.nvim',
        -- dev = true,
        lazy = true,
        cmd = 'Kyouko',
    },

    -- My colorscheme
    {
        'andry-dev/nofrils',
        -- dev = true,
        lazy = false,
        priority = 10000,
    },

    -- These color schemes are used for :SetupForScreens and :PrettyTheme
    -- I don't personally use them
    -- 'catppuccin/nvim',
    -- 'EdenEast/nightfox.nvim',
    -- 'savq/melange-nvim',
    -- 'bluz71/vim-moonfly-colors',
    -- 'gruvbox-community/gruvbox',
    -- 'sainnhe/everforest',
    -- 'shaunsingh/nord.nvim',
    -- 'JaySandhu/xcode-vim',
    -- 'daschw/leaf.nvim',
    {
        'navarasu/onedark.nvim',
        lazy = true
    },


    { 'nvim-lua/plenary.nvim' },

    {
        'lewis6991/spellsitter.nvim',
        config = function()
            require('spellsitter').setup()
        end
    },

    {
        "williamboman/mason.nvim",
        config = function()
            require('mason').setup()
        end
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'ray-x/lsp_signature.nvim',
            {
                'mfussenegger/nvim-jdtls',
                ft = 'java'
            },
            {
                'folke/trouble.nvim',
                cmd = 'Trouble'
            },
            {
                'simrat39/symbols-outline.nvim',
                cmd = 'SymbolsOutline'
            },
            'folke/neodev.nvim',
        },
        config = function()
            require('config.lsp')
        end,
    },

    {
        'creativenull/efmls-configs-nvim',
        version = '^v1',
        dependencies = { 'neovim/nvim-lspconfig' },
    },

    {
        'simrat39/rust-tools.nvim',
        lazy = true,
        ft = 'rust',
        config = function()
            require('rust-tools').setup({})
        end
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
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        opts = {
            load = {
                ['core.defaults'] = {},  -- Loads default behaviour
                ['core.concealer'] = {}, -- Adds pretty icons to your documents
                ['core.dirman'] = {      -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            concurrent_systems = '~/prj/uni/2022-2023//concurrent_systems',
                        },
                    },
                },
                ['core.integrations.treesitter'] = {
                    config = {}
                },
                ['core.completion'] = {
                    config = {
                        engine = 'nvim-cmp'
                    }
                }
            },
        },
        dependencies = { { "nvim-lua/plenary.nvim" } },
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
        },
        config = function()
            require('config.dap')
        end,
    },

    { 'prabirshrestha/async.vim' },

    {
        'L3MON4D3/LuaSnip',
        config = function()
            require('config.snippets')
        end,
    },

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'petertriho/cmp-git',
            'hrsh7th/cmp-path',
            'rcarriga/cmp-dap',
        },
        config = function()
            require('config.cmp')
        end
    },

    {
        'ibhagwan/fzf-lua'
    },

    -- Telescope
    --
    -- {
    --     {
    --         'nvim-telescope/telescope.nvim',
    --         dependencies = {
    --             'nvim-lua/popup.nvim',
    --             'nvim-lua/plenary.nvim',
    --             'telescope-frecency.nvim',
    --             'telescope-fzf-native.nvim',
    --         },
    --         config = function()
    --             require('config.telescope')
    --         end
    --     },
    --     {
    --         'nvim-telescope/telescope-frecency.nvim',
    --         -- after = 'telescope.nvim',
    --         dependencies = 'tami5/sqlite.lua',
    --         --[[ config = function()
    --             require('telescope').load_extension('frecency')
    --         end ]]
    --     },
    --     {
    --         'nvim-telescope/telescope-fzf-native.nvim',
    --         build = 'make',
    --     },
    -- },

    {
        'cdelledonne/vim-cmake',
        lazy = true,
        ft = 'cmake'
    },

    -- {'lambdalisue/suda.vim'},

    -- {
    --     'hkupty/iron.nvim',
    --     lazy = true,
    --     cmd = { 'IronRepl', 'IronReplHere' },
    --     config = function()
    --         require('config.iron')
    --     end
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

    -- {
    --     'tpope/vim-dadbod',
    --     { 'kristijanhusak/vim-dadbod-completion', dependencies = 'vim-dadbod' }
    -- },

    { 'editorconfig/editorconfig-vim' },

    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'nvim-neotest/neotest-go',
        },
        lazy = true,
        cmd = { 'NeotestFileRun', 'NeotestRun', 'NeotestSummary' },
        -- ft = {'go'},
        config = function()
            require('neotest').setup({
                adapters = {
                    require('neotest-go'),
                }
            })
        end
    },

    { 'vim-test/vim-test' },

    {
        'dhruvasagar/vim-testify',
        lazy = true,
        ft = { 'vim' },
        cmd = { 'TestifyFile' }
    },

    {
        'elixir-editors/vim-elixir',
        lazy = true,
        ft = { 'elixir' }
    },

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
