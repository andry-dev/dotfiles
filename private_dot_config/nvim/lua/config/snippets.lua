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

ls.add_snippets('tex', {
    ls.parser.parse_snippet({ trig = "beg", wordTrig = true }, "\\begin{$1}\n\t$2\n\\end{$1}"),
    ls.parser.parse_snippet({ trig = 'ls', wordTrig = true }, '\\begin{itemize}\n\t\\item $0\n\\end{itemize}'),
    ls.parser.parse_snippet({ trig = 'enm', wordTrig = true }, '\\begin{enumerate}\n\t\\item $0\n\\end{enumerate}'),
    ls.parser.parse_snippet({ trig = 'eq', wordTrig = true }, '\\begin{equation*}\n\t$0\n\\end{equation*}'),
    -- s('beg', {
    --     t { '\\begin{' }, i(1), t { '}', '' },
    --     i(0),
    --     t { '', '\\end{' }, i(1), t { '}' }
    -- })
})

ls.add_snippets('cpp', {
    ls.parser.parse_snippet({ trig = "main", wordTrig = true },
        [[int main(int argc, char* argv[]) {
    $0
}]]),
})
