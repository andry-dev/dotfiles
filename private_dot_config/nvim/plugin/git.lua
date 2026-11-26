require('gitsigns').setup()

require('octo').setup({
    picker = 'fzf-lua',

    enable_builtin = true,

    file_panel = {
        icons = false
    }
})
