vim.g.diagnostic_enable_underline = 1
vim.g.diagnostic_enable_virtual_text = 1
vim.g.diagnostic_enable_trimmed_virtual_text = 40
vim.diagnostic.config({
    virtual_text = true,
    float = {
        source = 'if_many'
    },
})
