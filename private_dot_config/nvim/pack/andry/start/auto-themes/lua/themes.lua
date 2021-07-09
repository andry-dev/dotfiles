local Module = {}

function Module.setup(config)
    local self = {
        dark_fn = function() end,
        dark = "default",
        light_fn = function() end,
        light = "default",
        daystart = 8,
        dayend = 19
    }

    for k, v in pairs(config) do self[k] = v end

    function self.set()
        local time = os.date("*t")
        local selected = { name = self.light, fn = self.light_fn }

        -- Set night theme if time is between [midnight, morning) OR [evening, midnight)
        if time.hour < self.daystart or time.hour >= self.dayend then
            selected = { name = self.dark, fn = self.dark_fn }
        end

        if vim.g.colors_name ~= selected.name then
            selected.fn()
            vim.cmd('silent colorscheme ' .. selected.name)
        end
    end

    return self
end

return Module
