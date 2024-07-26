local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local events = require("luasnip.util.events")

ls.config.set_config({
})

local function current_year()
    return os.date("%Y")
end

ls.add_snippets("all", {
    s("license", {
        t("SPDX-License-Identifier: "), i(1),
        t({"", "SPDX-FileCopyrightText: " .. current_year() .. " "}), i(2, "anri <me@anri.dev>"),
        t({""})
    })
})

ls.add_snippets("all", {
    s("license_szn", {
        t("SPDX-License-Identifier: "), i(1, "AGPL-3.0-or-later"),
        t({"", "SPDX-FileCopyrightText: "}), sn(2, {
            t(current_year() .. " Suzunaan "), i(1, "<SIG>"), t({" Contributors", ""})
        })
    }),
})

ls.add_snippets('cpp', {
    ls.parser.parse_snippet({ trig = "main", wordTrig = true },
        [[int main(int argc, char* argv[]) {
    $0
}]]),
})
