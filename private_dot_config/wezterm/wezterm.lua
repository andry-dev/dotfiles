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
        '#424242',                  -- Black
        '#B85C57',                  -- Red
        '#57864E',                  -- Green
        '#8F7634',                  -- Yellow
        'lch(55.07% 40.31 249.58)', -- Blue
        '#8888C7',                  -- Magenta
        '#6AA7A8',                  -- Cyan
        'silver',                   -- White
    },
    brights = {
        'grey',                  -- Black
        '#F2ACAA',               -- Red
        '#98CE8F',               -- Green
        '#B7B19C',               -- Yellow
        'lch(70% 23.57 236.42)', -- Blue
        '#D0D0F7',               -- Magenta
        'lch(70% 20.67 199.73)', -- Cyan
        'white',                 -- White
    },
}

local dark_colors = {
    background = '#262626',
    foreground = '#eeeeee',
    cursor_fg = 'black',
    cursor_bg = 'lch(90% 0% 0)',
    ansi = {
        'black',            -- Black
        'lch(80% 150% 20)', -- Red
        'lch(80% 10% 140)', -- Green
        'lch(80% 10% 90)',  -- Yellow
        'lch(80% 10% -90)', -- Blue
        'lch(80% 20% 0)',   -- Purple
        'lch(80% 10% 200)', -- Teal
        'lch(80% 0% 0)',    -- Silver
    },
    brights = {
        'lch(50% 0% 0)',
        'lch(100% 200% 20)', -- Red
        'lch(80% 20% 140)',
        'lch(80% 20% 90)',
        'lch(80% 20% -90)', -- Blue
        'lch(100% 20% 0)',  -- Purple
        'lch(80% 20% 200)', -- Teal
        'white',
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
    window_padding = {
        left = PADDING,
        right = PADDING,
        top = 0,
        bottom = 0,
    },
    enable_wayland = true,
    window_background_opacity = 1,
    font_size = device_settings.font_size,
    -- animation_fps = 144,
    max_fps = 144,
    -- front_end = 'WebGpu',
    -- Don't enable this or the window sizing breaks.
    -- window_decorations = "RESIZE",
    integrated_title_button_style = 'Gnome',
    hide_mouse_cursor_when_typing = false,
}
