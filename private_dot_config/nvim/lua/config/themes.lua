-- Normal theme configuration

local themes = {
    {
        set_dark_mode = function()
            vim.api.nvim_set_option("background", "dark")
            vim.cmd.colorscheme("nofrils-dark")
        end,
        set_light_mode = function()
            vim.api.nvim_set_option("background", "light")
            vim.cmd.colorscheme("nofrils-acme")
        end,
    },
    {
        set_dark_mode = function()
            require('onedark').setup {
                style = 'dark'
            }

            vim.cmd.colorscheme("onedark")
        end,
        set_light_mode = function()
            require('onedark').setup {
                style = 'light'
            }

            vim.cmd.colorscheme("onedark")
        end,
    }
}

local current_theme = 1

local LIGHT_SETTINGS = {
    LIGHT = 1,
    DARK = 2
}

-- 1 = light
-- 2 = dark
local last_light_setting = LIGHT_SETTINGS.LIGHT

local theme_config_shim = {
    update_interval = 1000,
    set_dark_mode = function()
        themes[current_theme].set_dark_mode()
        last_light_setting = LIGHT_SETTINGS.DARK
    end,

    set_light_mode = function()
        themes[current_theme].set_light_mode()
        last_light_setting = LIGHT_SETTINGS.LIGHT
    end,
}


local function setup_theming()
    vim.opt.termguicolors = true

    vim.g.nofrils_heavylinenumbers = 0
    vim.g.nofrils_heavycomments = 1
    vim.g.nofrils_strbackgrounds = 0
    -- vim.g.gruvbox_contrast_light = 'hard'
    -- vim.g.gruvbox_contrast_dark = 'hard'
end

local function reset_theme()
    local t = themes[current_theme]
    if last_light_setting == LIGHT_SETTINGS.LIGHT then
        t.set_light_mode()
    else
        t.set_dark_mode()
    end
end

local M = {}

local auto_dark_mode = require('auto-dark-mode');

function M.disable()
    auto_dark_mode.disable()
end

function M.set_default_theme()
    current_theme = 1
    reset_theme()
end

function M.set_pretty_theme()
    current_theme = 2
    reset_theme()
end

function M.setup()
    setup_theming()
    auto_dark_mode.setup(theme_config_shim)
end

return M
