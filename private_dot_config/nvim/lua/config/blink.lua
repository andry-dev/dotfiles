require('blink-cmp').setup {
    signature = { enabled = true },

    completion = {
        documentation = {
            auto_show = true,
        },
    },


    keymap = {
        preset = "default",
    },

    snippets = {
        preset = "luasnip",
    },

    cmdline = {
        enabled = false,
    },

    sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },

        providers = {
            -- dont show LuaLS require statements when lazydev has items
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                score_offset = 100,
            },

            buffer = {
                score_offset = -100,
            },
        },
    },
}
