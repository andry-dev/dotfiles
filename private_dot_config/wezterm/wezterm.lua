local wezterm = require('wezterm')

local PADDING = 5

local acme_colors = {
    background = '#ffffec',
    foreground = 'black',
    cursor_fg = 'white',
    cursor_bg = 'black',

    ansi = {
        'lch(0.0% 20 25)',
        'lch(6.25% 20 25)',
        'lch(12.5% 20 25)',
        'lch(18.75% 20 25)',
        'lch(25.0% 20 25)',
        'lch(31.25% 20 25)',
        'lch(37.5% 20 25)',
        'lch(43.75% 20 25)',
    },

    brights = {
        'lch(3.125% 20 25)',
        'lch(9.375% 20 25)',
        'lch(15.625% 20 25)',
        'lch(21.875% 20 25)',
        'lch(28.125% 20 25)',
        'lch(34.375% 20 25)',
        'lch(40.625% 20 25)',
        'lch(46.875% 20 25)',
    },

}

local dark_colors = {
    background = '#262626',
    foreground = '#eeeeee',
    cursor_fg = 'black',
    cursor_bg = 'lch(98% 0% 0)',

    ansi = {
        'lch(60.0% 20 25)',
        'lch(65.0% 20 25)',
        'lch(70.0% 20 25)',
        'lch(75.0% 20 25)',
        'lch(80.0% 20 25)',
        'lch(85.0% 20 25)',
        'lch(90.0% 20 25)',
        'lch(95.0% 20 25)',
    },

    brights = {
        'lch(62.5% 20 25)',
        'lch(67.5% 20 25)',
        'lch(72.5% 20 25)',
        'lch(77.5% 20 25)',
        'lch(82.5% 20 25)',
        'lch(87.5% 20 25)',
        'lch(92.5% 20 25)',
        'lch(97.5% 20 25)',
    },

    -- ansi = {
    --     'lch(60.0% 0 0)', -- Black
    --     'lch(65.0% 0 0)', -- Red
    --     'lch(70.0% 0 0)',
    --     'lch(75.0% 0 0)',
    --     'lch(80.0% 0 0)',
    --     'lch(85.0% 0 0)',
    --     'lch(90.0% 0 0)',
    --     'lch(95.0% 0 0)', -- White
    -- },
    --
    -- brights = {
    --     'lch(62.5% 0 0)', -- Black
    --     'lch(67.5% 0 0)', -- Red
    --     'lch(72.5% 0 0)',
    --     'lch(77.5% 0 0)',
    --     'lch(82.5% 0 0)',
    --     'lch(87.5% 0 0)',
    --     'lch(92.5% 0 0)',
    --     'lch(97.5% 0 0)', -- White
    -- },

}

local function get_hostname()
    return wezterm.hostname()
end

local function scheme_for_appearance(appearance)
    -- if true then
    --     return 'nofrils_acme'
    -- end

    if appearance:find 'Dark' then
        return 'nofrils_dark'
    else
        return 'nofrils_acme'
    end
end

local function select_default_font_size()
    local hn = get_hostname()
    if hn == 'kosuzu' then
        return 18
    elseif hn == 'aya' then
        return 14
    elseif hn == 'shiki' then
        return 24
    end
end

local device_settings = {
    font_size = select_default_font_size()
}

return {
    color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),

    color_schemes = {
        ['nofrils_acme'] = acme_colors,
        ['nofrils_dark'] = dark_colors,
        -- ['nofrils_light'] = light_colors,
    },

    font = wezterm.font {
        family = 'Pragmasevka',
        weight = 'Regular',
        -- stretch = 'Expanded',
        harfbuzz_features = {
            -- != == >= <=

            'calt=0',
            -- 'clig=0',
            -- 'liga=0'
        },
    },

    use_resize_increments = true,

    window_padding = {
        left = PADDING,
        right = PADDING,
        top = 0,
        bottom = 0,
    },

    enable_wayland = true,

    window_background_opacity = 1,

    font_size = device_settings.font_size,

    max_fps = 144,

    front_end = 'WebGpu',

    integrated_title_button_style = 'Gnome',

    hide_mouse_cursor_when_typing = false,
}
