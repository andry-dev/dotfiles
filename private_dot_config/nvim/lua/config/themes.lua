-- Normal theme configuration
local default_theme_config = require 'themes'.setup {
    daystart = 7,
    dayend = 16,
    light = 'nofrils-acme',
    dark = 'nofrils-dark',
}

-- Theme configuration for screenshots and such
local pretty_theme_config = require 'themes'.setup { default_theme_config }

pretty_theme_config.dark = "onedark"
pretty_theme_config.dark_fn = function()
    -- vim.opt.background = "dark"
    -- vim.g.catppuccin_flavour = "mocha"
    require('onedark').setup {
        -- style = 'darker'
    }
    -- require('onedark').load()
end

pretty_theme_config.light = "onedark"
pretty_theme_config.light_fn = function()
    -- vim.opt.background = "light"
    -- vim.g.catppuccin_flavour = "latte"
    require('onedark').setup {
        style = 'light'
    }
    -- require('onedark').load()
end

local function setup_theming()
    vim.opt.termguicolors = true

    vim.g.nofrils_heavylinenumbers = 0
    vim.g.nofrils_heavycomments = 1
    vim.g.nofrils_strbackgrounds = 0
    -- vim.g.gruvbox_contrast_light = 'hard'
    -- vim.g.gruvbox_contrast_dark = 'hard'
end

-- These are basically globals.
-- Needed to make the module idempotent with respect to state.
local theme_timer = vim.loop.new_timer()
local current_theme_config = default_theme_config

local M = {}

function M.start_timer()
    local minutes = 1
    theme_timer:start(0, minutes * 60 * 1000, vim.schedule_wrap(
        function() current_theme_config.set() end))
end

function M.stop_timer() theme_timer:stop() end

function M.set_default_theme()
    current_theme_config = default_theme_config
    current_theme_config.set()
end

function M.set_pretty_theme()
    current_theme_config = pretty_theme_config
    current_theme_config.set()
end

function M.get_theme_config() return current_theme_config end

function M.setup()
    setup_theming()
    current_theme_config.set()
    M.start_timer()
end

return M