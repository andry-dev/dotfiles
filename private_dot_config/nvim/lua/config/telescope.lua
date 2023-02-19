local telescope = require('telescope')

telescope.setup {
    defaults = {
        layout_config = {
            horizontal = {}
        }
    },
    extensions = {
        frecency = {

        },

        fzf = {

        }
    }
}

telescope.load_extension('frecency')
telescope.load_extension('fzf')

--telescope.setup
