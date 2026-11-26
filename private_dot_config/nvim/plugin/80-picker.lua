require('fzf-lua').setup({
    winopts = { treesitter = { enabled = false }, },
    previewers = { builtin = { syntax = false, treesitter = false } },
})

require('fzf-lua').register_ui_select()
