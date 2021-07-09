local globals = require 'globals'

local lsp = require 'lspconfig'
-- local configs = require 'lspconfig/configs'


-- require('lsp_signature').on_attach()

-- TODO(andry, 2021-01-04): This is actually bad tbh.
-- Maybe refactor it to something better?

function should_format()
    if globals.autoformat_enabled() then vim.lsp.buf.formatting() end
end

vim.lsp.handlers["textDocument/formatting"] =
    function(err, _, result, _, bufnr)
        if err ~= nil or result == nil then return end
        if not vim.api.nvim_buf_get_option(bufnr, "modified") then
            local view = vim.fn.winsaveview()
            vim.lsp.util.apply_text_edits(result, bufnr)
            vim.fn.winrestview(view)
            if bufnr == vim.api.nvim_get_current_buf() then
                vim.api.nvim_command("noautocmd :update")
            end
        end
    end

local custom_attach = function(client)
    if client.resolved_capabilities.document_formatting then
        vim.cmd [[augroup Format]]
        vim.cmd [[autocmd! * <buffer>]]
        vim.cmd [[autocmd BufWritePost <buffer> lua should_format()]]
        vim.cmd [[augroup END]]
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalText'
  }
}

lsp.solargraph.setup {on_attach = custom_attach}

lsp.clangd.setup {
    on_attach = custom_attach,
    capabilities = capabilities,

    cmd = {
        "clangd", "--background-index", "--cross-file-rename", "--clang-tidy",
        "--recovery-ast"
    }
}

lsp.cmake.setup {on_attach = custom_attach}

lsp.elixirls.setup {
    root_dir = lsp.util.root_pattern(".git", "mix.exs"),
    on_attach = custom_attach,
    capabilities = capabilities,
    -- cmd = {ElixirLS_path .. '/release/language_server.sh'}
}

lsp.html.setup {
    on_attach = custom_attach,
    capabilities = capabilities
}

--[[
lsp.jdtls.setup {
    on_attach = custom_attach,
    root_dir = lsp.util.root_pattern(".git", "pom.xml", "build.gradle")
}
--]]

lsp.intelephense.setup {
    on_attach = custom_attach,
    capabilities = capabilities
}

lsp.sqlls.setup {
    on_attach = custom_attach,
    capabilities = capabilities
    -- cmd = {'sql-language-server', 'up', '--method', 'stdio'}
}


require('nlua.lsp.nvim').setup(lsp, {
    cmd = {globals.sumneko_binary, "-E", globals.sumneko_basepath .. "/main.lua"},
    on_attach = custom_attach,
    capabilities = capabilities
})

--[[
-- TODO(andry, 2021-01-04): This only works for neovim :(
lsp.sumneko_lua.setup {
    on_attach = custom_attach,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
            workspace = {
            }
        }
    }
}
--]]

lsp.cssls.setup {
    on_attach = custom_attach,
    capabilities = capabilities

}

lsp.pyls.setup {
    on_attach = custom_attach,
    capabilities = capabilities
}

lsp.yamlls.setup {
    on_attach = custom_attach,
    capabilities = capabilities
}

lsp.efm.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
    filetypes = {
        "vim", "json", "html", "yaml", "css", "go", "sh", "javascript"
    }
}

lsp.vuels.setup {
    on_attach = custom_attach,
    capabilities = capabilities
}

lsp.texlab.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
    settings = {
        latex = {
            build = {onSave = true, forwardSearchAfter = true},
            forwardSearch = {
                executable = "okular",
                args = {"--unique", "file:%p#src:%l%f"}
            },
            lint = {onChange = true}
        }
    }
}

require('symbols-outline').setup({
    highlight_hovered_item = true,
    show_guides = true
})

-- require 'lspinstall'.setup()


-- Export my configuration to other modules just in case I need it elsewhere.
return {on_attach = custom_attach}
