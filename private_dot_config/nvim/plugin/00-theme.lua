-- Normal theme configuration

local theme_was_set_automatically = false

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
            vim.o.background = "dark"
            vim.cmd.colorscheme("gruvbox")

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
            vim.o.background = "light"
            vim.cmd.colorscheme("gruvbox")

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
        theme_was_set_automatically = true
    end,

    set_light_mode = function()
        themes[current_theme].set_light_mode()
        last_light_setting = LIGHT_SETTINGS.LIGHT
        theme_was_set_automatically = true
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

    auto_dark_mode.setup(theme_config_shim)

    if not theme_was_set_automatically then
        local current_hour = tonumber(os.date '%H')
        if current_hour >= 6 and current_hour <= 17 then
            theme_config_shim.fallback = 'light'
            themes[current_theme].set_light_mode()
        else
            theme_config_shim.fallback = 'dark'
            themes[current_theme].set_dark_mode()
        end
    end
end

vim.api.nvim_create_user_command('DefaultTheme', function()
    M.set_default_theme()
end, {})

vim.api.nvim_create_user_command('PrettyTheme', function()
    M.set_pretty_theme()
end, {})

vim.api.nvim_create_user_command('SetupForScreens', function()
    local lang = vim.v.lang
    local spell = vim.opt.spell:get()

    vim.cmd.language("en_US.UTF-8")
    vim.opt.spell = false

    M.set_pretty_theme()

    vim.cmd.redraw()
    vim.fn.getchar()

    M.set_default_theme()

    vim.cmd.language(lang)
    vim.opt.spell = spell
end, {})

M.setup()
