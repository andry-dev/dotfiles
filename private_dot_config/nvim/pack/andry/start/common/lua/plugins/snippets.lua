local snippets = require 'snippets'
local utils = require 'snippets.utils'

snippets.use_suggested_mappings()

local macro_if_snippet = [[
#if ${1:CONDITION}
$0
#endif // $1
]]

local c_while = [[
while ($1)
{
    $0
}
]]

local c_if = [[
if ($1)
{
    $0
}
]]

local c_for = [[
for (${1:int} ${2:i} = ${3:0}; $2 < $4; ++$2)
{
    $0
}
]]

local function today()
    return os.date("%Y-%m-%d")
end

snippets.snippets = {
    _global = {
        today = today,
        todo = "TODO(andry, " .. today() .. "): $0",
    },

    lua = {

    },

    c = {
        ["#if"] = macro_if_snippet,
        ["if"] = c_if,
        ["while"] = c_while,
        ["for"] = c_for,
    },

    cpp = {
        ["#if"] = macro_if_snippet,
        ["if"] = c_if,
        ["while"] = c_while,
        ["for"] = c_for,
    },

    elixir = {
        insp = '|> IO.inspect()'
    },

    tex = {
        list = utils.match_indentation [[
\begin{enumerate}
    \item $0
\end{enumerate}
]],
        blist = utils.match_indentation [[
\begin{itemize}
    \item $0
\end{itemize}
]],
        ["table"] = utils.match_indentation [[
\begin{figure}
    \begin{tabular}
        $0
    \end{tabular}
\end{figure}
]],
        mm = [[\$$0\$]],
        md = utils.match_indentation [[\\[ $0 \\] ]],
        eps = [[\\epsilon]],
        rarr = [[\\rightarrow]],
        Rarr = [[\\Rightarrow]],
        larr = [[\\leftarrow]],
        Larr = [[\\Leftarrow]],
        lim = [[\\lim_{${1:n \to \infty}} $0]],
        int = [[\\int_{${1:-\\infty}}^{${2:+\\infty}} $0]],
        sum = [[\\sum_{${1:k = 1}}^{${2:n}} $0]],
        prod = [[\\prod_{${1:k = 1}}^{${2:n}} $0]],
        beg = utils.match_indentation [[
\begin{$1}
    $0
\end{$1}
]]
    },
}
