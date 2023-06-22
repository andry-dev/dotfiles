local null_ls = require('null-ls')

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.commitlint,
        -- null_ls.builtins.diagnostics.editorconfig_checker,
        null_ls.builtins.diagnostics.glslc,
        null_ls.builtins.diagnostics.mdl
    }
})

require('mason-null-ls').setup({
    automatic_installation = true
})
