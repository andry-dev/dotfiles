vim.pack.add({
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/jfpedroza/neotest-elixir",
    'https://github.com/nvim-neotest/neotest-go',
    'https://github.com/nvim-neotest/neotest-python',
    'https://github.com/mrcjkb/rustaceanvim',
    'https://github.com/nvim-neotest/neotest',
})


require('neotest').setup({
    adapters = {
        require('neotest-go'),
        require('neotest-elixir'),
        require('neotest-python')({
            dap = { justMyCode = true },
        }),
        require('rustaceanvim.neotest'),
    }
})
