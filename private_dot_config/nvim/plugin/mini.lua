vim.pack.add({
    'https://github.com/nvim-mini/mini.ai',
    'https://github.com/nvim-mini/mini.surround',
})

local gen_spec = require('mini.ai').gen_spec
require('mini.ai').setup({
    custom_textobjects = {
        c = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
        F = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
        p = gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
        I = gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }),
        O = gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }),
    }
})
