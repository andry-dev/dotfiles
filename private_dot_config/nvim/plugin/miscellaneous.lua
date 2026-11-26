vim.pack.add({
    'https://github.com/tpope/vim-dispatch',

    "https://github.com/eraserhd/parinfer-rust",

    {
        src = 'https://github.com/chomosuke/typst-preview.nvim',
        version = vim.version.range('1.*')
    },

    "https://github.com/zk-org/zk-nvim",

    'https://github.com/danymat/neogen',

    'https://github.com/kristijanhusak/vim-dadbod-completion',
    'https://github.com/kristijanhusak/vim-dadbod-ui',
    'https://github.com/tpope/vim-dadbod',

    "https://github.com/m4xshen/hardtime.nvim",

})

require('typst-preview').setup({})

require("zk").setup({
    picker = "fzf_lua",
})

require('neogen').setup {
    enabled = true
}

require('hardtime').setup({
    disable_mouse = false,
    max_time = 5000,

    -- I use <Left> / <Right> for `:cprev`, `:cnext`.
    disabled_keys = {
        ['<Left>'] = { 'i', 'x', 'o' },
        ['<Right>'] = { 'i', 'x', 'o' },
    }
})

