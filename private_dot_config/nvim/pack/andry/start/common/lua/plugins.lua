vim.cmd [[packadd packer.nvim]]
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

local packer = require('packer')

return packer.startup(function()
    local use = packer.use

    use { 'wbthomason/packer.nvim', opt = true }

    use { 'nvim-lua/plenary.nvim' }

    use {
        'neovim/nvim-lspconfig',
        'ray-x/lsp_signature.nvim',
        'mfussenegger/nvim-jdtls',
        'folke/trouble.nvim',
        'simrat39/symbols-outline.nvim',

        -- config = function()
        --     require('config.lsp')
        -- end,

        after = 'nvim-cmp',
    }

    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'neovim/nvim-lspconfig',
        },
    }

    use {
        'simrat39/rust-tools.nvim',
        opt = true,
        ft = 'rust',
        config = function()
            require('rust-tools').setup({})
        end
    }


    -- use {'jubnzv/virtual-types.nvim'}

    use { 'michaelb/sniprun', run = 'bash ./install.sh' }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = {
            -- 'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-refactor',
            -- 'romgrk/nvim-treesitter-context',
            'windwp/nvim-ts-autotag',
        }
    }

    use {
        'danymat/neogen',
        config = function()
            require('neogen').setup {
                enabled = true
            }
        end,
        requires = 'nvim-treesitter'
    }

    -- use { 'nvim-neorg/neorg'}
    use {
        'nvim-orgmode/orgmode',
        requires = {
            'dhruvasagar/vim-table-mode',
            'nvim-treesitter/nvim-treesitter'
        },
        config = function()
            require('orgmode').setup {}
        end
    }

    use {
        'mfussenegger/nvim-dap',
        config = function()
            require('config.dap')
        end
    }

    use {
        'theHamsta/nvim-dap-virtual-text',
        requires = {
            'nvim-dap',
            'nvim-treesitter',
        }
    }

    use {
        "rcarriga/nvim-dap-ui",
        requires = {
            'mfussenegger/nvim-dap'
        },
        after = 'nvim-dap',
        config = function()
            require('dapui').setup()
        end
    }

    use {
        "mfussenegger/nvim-dap-python",
        requires = {
            "mfussenegger/nvim-dap"
        },
    }

    use { 'tjdevries/nlua.nvim' }

    use {
        -- My colorscheme
        'andry-dev/nofrils',


        -- These color schemes are used for :SetupForScreens and :PrettyTheme
        -- I don't personally use them
        'catppuccin/nvim',
        -- 'bluz71/vim-moonfly-colors',
        -- 'gruvbox-community/gruvbox',
        -- 'sainnhe/everforest',
        -- 'shaunsingh/nord.nvim',
        -- 'JaySandhu/xcode-vim',
        -- 'daschw/leaf.nvim',
    }

    use { 'lervag/vimtex', ft = { 'tex' } }

    use { 'prabirshrestha/async.vim' }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'L3MON4D3/LuaSnip',
            { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
            {
                'saadparwaiz1/cmp_luasnip',
                requires = {
                    'LuaSnip',
                    'nvim-cmp'
                }
            }
        },
        config = function()
            require('config.cmp')
        end
    }

    use {
        'ibhagwan/fzf-lua'
    }

    -- Telescope
    --
    -- use {
    --     {
    --         'nvim-telescope/telescope.nvim',
    --         requires = {
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
    --         requires = 'tami5/sqlite.lua',
    --         --[[ config = function()
    --             require('telescope').load_extension('frecency')
    --         end ]]
    --     },
    --     {
    --         'nvim-telescope/telescope-fzf-native.nvim',
    --         run = 'make',
    --     },
    -- }

    use { 'cdelledonne/vim-cmake' }

    -- use {'lambdalisue/suda.vim'}

    use {
        'hkupty/iron.nvim',
        opt = true,
        cmd = { 'IronRepl', 'IronReplHere' },
        config = function()
            require('config.iron')
        end
    }

    use {
        'tpope/vim-dispatch',
        opt = true,
        cmd = { 'Dispatch', 'Make', 'Start' }
    }

    use {
        'tpope/vim-fugitive',
        'tpope/vim-rhubarb',
        { 'junegunn/gv.vim', requires = 'tpope/vim-fugitive' }
    }


    use {
        'tpope/vim-dadbod',
        { 'kristijanhusak/vim-dadbod-completion', requires = 'vim-dadbod' }
    }

    use { 'editorconfig/editorconfig-vim' }

    -- use {'thaerkh/vim-workspace'}

    use { 'vim-test/vim-test' }

    use {
        'dhruvasagar/vim-testify',
        opt = true,
        ft = { 'vim' },
        cmd = { 'TestifyFile' }
    }

    use { 'elixir-editors/vim-elixir', opt = true, ft = { 'elixir' } }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('config.comment')
        end
    }

    use { 'tami5/sqlite.lua' }
end)
