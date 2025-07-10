local wezterm = require('wezterm')

local PADDING = 5

local light_colors = {
    background = '#E4E4E4',
    foreground = 'black',
    cursor_fg = 'white',
    cursor_bg = 'black',
    ansi = {
        'black',
        'maroon',
        '#50AA50', -- green
        'olive',
        'navy',
        'purple',
        'teal',
        'silver',
    },

    brights = {
        'grey',
        'red',
        'lch(20% 200% 140)', -- Light Green
        'lch(20% 50% 90)',   -- Light Yellow
        '#5050AA',
        'fuchsia',
        '#509090',
        'white',
    },
}

local acme_colors = {
    background = '#ffffec',
    foreground = 'black',
    cursor_fg = 'white',
    cursor_bg = 'black',
    ansi = {
        'lch(0% 0 0)',     -- Black
        'lch(13.33% 0 0)', -- Red
        'lch(26.66% 0 0)', -- Green
        'lch(40.00% 0 0)', -- Yellow
        'lch(53.33% 0 0)', -- Blue
        'lch(66.67% 0 0)', -- Magenta
        'lch(90.00% 0 0)', -- Cyan
        'lch(93.33% 0 0)', -- White
    },

    brights = {
        'lch(6.66% 0 0)',  -- Black
        'lch(20% 0 0)',    -- Red
        'lch(33.33% 0 0)', -- Green
        'lch(46.66% 0 0)', -- Yellow
        'lch(60.00% 0 0)', -- Blue
        'lch(73.33% 0 0)', -- Magenta
        'lch(86.67% 0 0)', -- Cyan
        '#ffffec',         -- White
    },
}

local dark_colors = {
    background = '#262626',
    foreground = '#eeeeee',
    cursor_fg = 'black',
    cursor_bg = 'lch(90% 0% 0)',
    ansi = {
        '#262626',         -- Black
        'lch(93.33% 0 0)', -- White
        'lch(90.00% 0 0)', -- Cyan
        'lch(66.67% 0 0)', -- Magenta
        'lch(53.33% 0 0)', -- Blue
        'lch(40.00% 0 0)', -- Yellow
        'lch(26.66% 0 0)', -- Green
        'lch(13.33% 0 0)', -- Red
    },
    brights = {
        'lch(6.66% 0 0)',  -- Black
        'lch(86.67% 0 0)', -- Cyan
        'lch(73.33% 0 0)', -- Magenta
        'lch(60.00% 0 0)', -- Blue
        'lch(46.66% 0 0)', -- Yellow
        'lch(33.33% 0 0)', -- Green
        'lch(20% 0 0)',    -- Red
        '#eeeeee',         -- White
    },
}

local function get_hostname()
    return wezterm.hostname()
end

local function scheme_for_appearance(appearance)
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
        ['nofrils_light'] = light_colors,
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
