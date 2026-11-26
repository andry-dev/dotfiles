-- TexLab provides both compilation and completion
vim.g.vimtex_compiler_enabled = 0
vim.g.vimtex_complete_enabled = 0

vim.keymap.set("n", "<localleader>lt", function()
    return require("vimtex.fzf-lua").run()
end)
