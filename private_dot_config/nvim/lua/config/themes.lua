-- Normal theme configuration

local LIGHT_SETTINGS = {
    LIGHT = 1,
    DARK = 2
}

local THEME_KIND = {
    DEFAULT = 1,
    PRETTY = 2,
}

local themes = {
    [THEME_KIND.DEFAULT] = {
        set_dark_mode = function()
            vim.o.background = "dark"
            vim.cmd.colorscheme("nofrils-dark")
        end,
        set_light_mode = function()
            vim.o.background = "light"
            vim.cmd.colorscheme("nofrils-acme")
        end,
    },

    [THEME_KIND.PRETTY] = {
        set_dark_mode = function()
            vim.cmd.colorscheme("duskfox")

            vim.api.nvim_set_hl(0, 'FocusHL_red', {
                bg = '#602020'
            })
            vim.api.nvim_set_hl(0, 'FocusHL_green', {
                bg = '#206020'
            })
            vim.api.nvim_set_hl(0, 'FocusHL_blue', {
                bg = '#202060'
            })
        end,

        set_light_mode = function()
            vim.cmd.colorscheme("dawnfox")

            vim.api.nvim_set_hl(0, 'FocusHL_red', {
                bg = '#FEE0E0'
            })
            vim.api.nvim_set_hl(0, 'FocusHL_green', {
                bg = '#E0FEE0'
            })
            vim.api.nvim_set_hl(0, 'FocusHL_blue', {
                bg = '#E0E0FE'
            })
        end,
    }
}

local current_theme = THEME_KIND.DEFAULT

-- 1 = light
-- 2 = dark
local last_light_setting = LIGHT_SETTINGS.LIGHT

local theme_config_shim = {
    update_interval = 1000,

    -- fallback = "light",

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
    vim.g.nofrils_strbackgrounds = 1
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
    current_theme = THEME_KIND.DEFAULT
    reset_theme()
end

function M.set_pretty_theme()
    current_theme = THEME_KIND.PRETTY
    reset_theme()
end

function M.setup()
    setup_theming()

    local current_hour = tonumber(os.date '%H')
    if current_hour >= 6 and current_hour <= 20 then
        theme_config_shim.fallback = 'light'
        themes[current_theme].set_light_mode()
    else
        theme_config_shim.fallback = 'dark'
        themes[current_theme].set_dark_mode()
    end

    auto_dark_mode.setup(theme_config_shim)
    -- reset_theme()
end

return M
