local wezterm = require('wezterm')

local acme_colors = {
    background = '#ffffd7',
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
    font = wezterm.font(
        'Go Mono'
    ),
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    font_size = 10,
    front_end = 'WebGpu',
    hide_mouse_cursor_when_typing = false,
}
