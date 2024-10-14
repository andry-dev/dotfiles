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
        -- dir = '~/prj/nofrils',
        dev = true,
        lazy = false,
        priority = 10000,
    },

    {
        "f-person/auto-dark-mode.nvim",
        lazy = false,

        dependencies = {
            'andry-dev/nofrils'
        },

        config = function()
            require('config.themes').setup()
        end
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
        "williamboman/mason.nvim",
        config = function()
            if vim.g.mason_enabled then
                require('mason').setup()
            end
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
            'b0o/SchemaStore.nvim',
            'barreiroleo/ltex-extra.nvim',
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

    {
        'stevearc/overseer.nvim',
        opts = {},
        dependencies = {
            'mfussenegger/nvim-dap',
        },
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
        -- 'hrsh7th/nvim-cmp',
        -- 'yioneko/nvim-cmp',
        -- branch = 'perf-up',
        'iguanacucumber/magazine.nvim',
        name = 'nvim-cmp',
        enabled = true,
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'petertriho/cmp-git',
            'hrsh7th/cmp-path',
            'rcarriga/cmp-dap',
            'kristijanhusak/vim-dadbod-completion',
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "luvit-meta/library", words = { "vim%.uv" } },
                    },
                },
            },
            { "Bilal2453/luvit-meta", lazy = true },
        },
        config = function()
            require('config.cmp')
        end
    },

    {
        'saghen/blink.cmp',
        enabled = false,
        lazy = false, -- lazy loading handled internally
        -- optional: provides snippets for the snippet source
        dependencies = 'rafamadriz/friendly-snippets',

        -- use a release tag to download pre-built binaries
        version = 'v0.*',
        -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',

        opts = {
            highlight = {
                -- sets the fallback highlight groups to nvim-cmp's highlight groups
                -- useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release, assuming themes add support
                use_nvim_cmp_as_default = true,
            },

            -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- adjusts spacing to ensure icons are aligned
            -- nerd_font_variant = 'normal',

            -- experimental auto-brackets support
            -- accept = { auto_brackets = { enabled = true } }

            -- experimental signature help support
            trigger = { signature_help = { enabled = true } },

            keymap = {
                select_prev = '<C-p>',
                select_next = '<C-n>',
                accept = '<C-y>',
                snippet_forward = '<C-l>',
                snippet_backward = '<C-h>',
            },

            sources = {
                -- similar to nvim-cmp's sources, but we point directly to the source's lua module
                -- multiple groups can be provided, where it'll fallback to the next group if the previous
                -- returns no completion items
                -- WARN: This API will have breaking changes during the beta
                providers = {
                    {
                        { 'blink.cmp.sources.lsp' },
                        { 'blink.cmp.sources.path' },
                        -- { 'blink.cmp.sources.snippets', score_offset = -10 },
                    },
                    { { 'blink.cmp.sources.buffer' } },
                },
            },
        },
    },

    {
        'ibhagwan/fzf-lua'
    },

    {
        'cdelledonne/vim-cmake',
        lazy = true,
        ft = 'cmake'
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
        'kristijanhusak/vim-dadbod-completion',
        'kristijanhusak/vim-dadbod-ui',
    },

    { 'editorconfig/editorconfig-vim' },

    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'nvim-neotest/neotest-go',
            'stevearc/overseer.nvim',
        },
        lazy = true,
        cmd = { 'NeotestFileRun', 'NeotestRun', 'NeotestSummary' },
        -- ft = {'go'},
        config = function()
            require('neotest').setup({
                consumers = {
                    overseer = require('neotest.consumers.overseer')
                },
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
