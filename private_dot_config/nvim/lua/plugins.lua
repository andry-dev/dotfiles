vim.cmd [[packadd packer.nvim]]
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

local packer = require('packer')

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

return packer.startup(function()
    local use = packer.use

    use { 'wbthomason/packer.nvim', opt = true }

    local nofrils_path = dev_plugin('~/prj/nofrils') or 'andry-dev/nofrils'

    local kyouko_path = dev_plugin('~/prj/kyouko.nvim') or 'andry-dev/kyouko.nvim'

    use {
        kyouko_path
    }

    use {
        -- My colorscheme
        nofrils_path,

        -- These color schemes are used for :SetupForScreens and :PrettyTheme
        -- I don't personally use them
        -- 'catppuccin/nvim',
        -- 'EdenEast/nightfox.nvim',
        -- 'savq/melange-nvim',
        'navarasu/onedark.nvim',
        -- 'bluz71/vim-moonfly-colors',
        -- 'gruvbox-community/gruvbox',
        -- 'sainnhe/everforest',
        -- 'shaunsingh/nord.nvim',
        -- 'JaySandhu/xcode-vim',
        -- 'daschw/leaf.nvim',
    }


    use { 'nvim-lua/plenary.nvim' }

    use {
        'lewis6991/spellsitter.nvim',
        config = function()
            require('spellsitter').setup()
        end
    }

    use {
        "williamboman/mason.nvim",
        config = function()
            require('mason').setup()
        end
    }

    use {
        'neovim/nvim-lspconfig',
        'williamboman/mason-lspconfig.nvim',
        'ray-x/lsp_signature.nvim',
        'mfussenegger/nvim-jdtls',
        'folke/trouble.nvim',
        'simrat39/symbols-outline.nvim',
        'folke/neodev.nvim',

        config = function()
            require('config.lsp')
        end,

        after = { 'nvim-cmp', 'williamboman/mason.nvim' },
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
        },
        config = function()
            require('config.treesitter')
        end
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

        requires = {
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

        -- after = { 'williamboman/mason.nvim' }
    }
    -- use { 'tjdevries/nlua.nvim' }

    -- use { 'lervag/vimtex', ft = { 'tex' } }

    use { 'prabirshrestha/async.vim' }

    use {
        'hrsh7th/nvim-cmp',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'rcarriga/cmp-dap',
        config = function()
            require('config.snippets')
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

    -- use {
    --     'hkupty/iron.nvim',
    --     opt = true,
    --     cmd = { 'IronRepl', 'IronReplHere' },
    --     config = function()
    --         require('config.iron')
    --     end
    -- }

    use {
        'tpope/vim-dispatch',
        opt = true,
        cmd = { 'Dispatch', 'Make', 'Start' }
    }

    use {
        'tpope/vim-fugitive',
        'tpope/vim-rhubarb',
        { 'junegunn/gv.vim', requires = 'tpope/vim-fugitive' },
        { 'lewis6991/gitsigns.nvim',
            config = function()
                require('gitsigns').setup()
            end }
    }

    -- use {
    --     'tpope/vim-dadbod',
    --     { 'kristijanhusak/vim-dadbod-completion', requires = 'vim-dadbod' }
    -- }

    use { 'editorconfig/editorconfig-vim' }

    use {
        'nvim-neotest/neotest',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'nvim-neotest/neotest-go',
        },
        config = function()
            require('neotest').setup({
                adapters = {
                    require('neotest-go'),
                }
            })
        end
    }

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

    use {
        'stevearc/oil.nvim',
        config = function() require('oil').setup() end
    }

    use { 'tami5/sqlite.lua' }
end)
