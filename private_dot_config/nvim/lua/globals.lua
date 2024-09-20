local M = {}

function P(t)
    print(vim.inspect(t))
    return t
end

function R(m)
    package.loaded[m] = nil

    return require(m)
end

local function get_system_name()
    if vim.fn.has("mac") == 1 then
        return "macOS"
    elseif vim.fn.has("unix") == 1 then
        return "Linux"
    elseif vim.fn.has('win32') == 1 then
        return "Windows"
    end
end

local lsp_folder_path = os.getenv("HOME") .. "/.lsp"

M.system_name = get_system_name()

M.elixirls_basepath = lsp_folder_path .. '/elixir-ls'
M.sumneko_basepath = lsp_folder_path .. '/lua-language-server'
M.sumneko_binary = M.sumneko_basepath .. '/bin/lua-language-server'
M.pyls_ms_binary = lsp_folder_path .. '/python-language-server/output/bin/Release/Microsoft.Python.LanguageServer.dll'

return M
