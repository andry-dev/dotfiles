local wezterm = require('wezterm')

local acme_colors = {
    background = '#ffffd7',
    foreground = 'black',
    cursor_fg = 'white',
    cursor_bg = 'black',
    ansi = {
        'black',
        'maroon',
        'green',
        'olive',
        'navy',
        'purple',
        'teal',
        'silver',
    },
    brights = {
        'grey',
        'red',
        'lime',
        'yellow',
        '#5050AA',
        'fuchsia',
        '#509090',
        'white',
    },
}

local dark_colors = {
    background = '#262626',
    foreground = '#eeeeee',
    cursor_fg = 'black',
    cursor_bg = '#00ffff',
    ansi = {
        'black',
        '#B09090', -- Maroon
        'green',
        'olive',
        'navy',
        'purple',
        'teal',
        'silver',
    },
    brights = {
        'grey',
        '#FFA0A0', -- Red
        'lime',
        'yellow',
        '#A0A0E0', -- Blue
        'fuchsia',
        '#90E0E0', -- Acqua
        'white',
    },
}

local function scheme_for_appearance(appearance)
    if appearance:find 'Dark' then
        return 'nofrils_dark'
    else
        return 'nofrils_acme'
    end
end

return {
    color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
    color_schemes = {
        ['nofrils_acme'] = acme_colors,
        ['nofrils_dark'] = dark_colors,
    },
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    font_size = 10,
}
