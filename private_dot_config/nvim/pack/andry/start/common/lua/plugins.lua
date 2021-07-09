vim.cmd [[packadd packer.nvim]]
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

local packer = require('packer')

return packer.startup(function()
    use {'wbthomason/packer.nvim', opt = true}
    use {'svermeulen/vimpeccable'}

    -- use { 'camspiers/snap', rocks = {'fzy'} }

    use {'neovim/nvim-lspconfig', as = 'nvim-lspconfig'}
    use {'kabouzeid/nvim-lspinstall'}

    use {'mfussenegger/nvim-jdtls', opt = true, ft = {"java"}}

    use {'nvim-lua/plenary.nvim'}

    use {'simrat39/symbols-outline.nvim'}

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
        -- {'nvim-treesitter/nvim-tree-docs', requires = 'nvim-treesitter'},
    }

    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        requires = 'nvim-treesitter/nvim-treesitter'
    }
    -- use {'nvim-treesitter/nvim-tree-docs', requires = 'nvim-treesitter/nvim-treesitter'}
    use {
        'nvim-treesitter/nvim-treesitter-refactor',
        requires = 'nvim-treesitter/nvim-treesitter'
    }

    -- Still can't decide which one to use
    use {'puremourning/vimspector'}

    use {
        'mfussenegger/nvim-dap',
        as = 'nvim-dap',
        {
            'theHamsta/nvim-dap-virtual-text',
            requires = {'nvim-dap', 'nvim-treesitter/nvim-treesitter'}
        }
    }

    use {'tjdevries/nlua.nvim'}

    use {'robertmeta/nofrils'}

    -- use {'lervag/vimtex', ft = {'tex'}}

    use {'prabirshrestha/async.vim'}

    use {'hrsh7th/nvim-compe'}

    use {'junegunn/fzf', as = 'fzf', {'junegunn/fzf.vim', requires = 'fzf'}}

    use {'cdelledonne/vim-cmake'}

    -- use {'lambdalisue/suda.vim'}

    use {'hkupty/iron.nvim', opt = true, cmd = {'IronRepl', 'IronReplHere'}}

    use {
        'tpope/vim-dispatch',
        opt = true,
        cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
    }

    use {'tpope/vim-fugitive', {
        'tpope/vim-rhubarb'
    }}

    use {'junegunn/gv.vim', requires = 'tpope/vim-fugitive'}

    use {'tpope/vim-dadbod', as = 'dadbod'}

    use {'kristijanhusak/vim-dadbod-completion', requires = 'dadbod'}

    use {'editorconfig/editorconfig-vim'}

    -- use {'thaerkh/vim-workspace'}

    use {'vim-test/vim-test'}

    use {
        'dhruvasagar/vim-testify',
        opt = true,
        ft = {'vim'},
        cmd = {'TestifyFile'}
    }

    use {'elixir-editors/vim-elixir', opt = true, ft = {'elixir'}}

    -- Both of these color schemes are used for :SetupForScreens and :PrettyTheme
    -- I don't personally use them
    use {'bluz71/vim-moonfly-colors'}
    use {'gruvbox-community/gruvbox'}
    -- use {'JaySandhu/xcode-vim'}

    use {'norcalli/snippets.nvim'}

    use {'vimwiki/vimwiki', {'tools-life/taskwiki'}}

    use {'b3nj5m1n/kommentary'}
end)
