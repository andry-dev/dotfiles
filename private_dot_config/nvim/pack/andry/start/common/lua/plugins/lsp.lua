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
    function(err, result, context, _)
        if err ~= nil or result == nil then return end
        if not vim.api.nvim_buf_get_option(context.bufnr, "modified") then
            local view = vim.fn.winsaveview()
            vim.lsp.util.apply_text_edits(result, context.bufnr)
            vim.fn.winrestview(view)
            if context.bufnr == vim.api.nvim_get_current_buf() then
                vim.api.nvim_command("noautocmd :update")
            end
        end
    end

local custom_attach = function(client)
    -- require('lsp_signature').on_attach()
    -- require('virtualtypes').on_attach()
    if client.resolved_capabilities.document_formatting then
        vim.cmd [[augroup Format]]
        vim.cmd [[autocmd! * <buffer>]]
        vim.cmd [[autocmd BufWritePost <buffer> lua should_format()]]
        vim.cmd [[augroup END]]
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
--[[
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalText'
  }
}
--]]

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
    cmd = {globals.elixirls_basepath .. '/release/language_server.sh'}
}

--[[
lsp.ansiblels.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
}
--]]

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

--[[
lsp.sqlls.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
    cmd = {'sql-language-server', 'up', '--method', 'stdio'}
}
--]]

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

lsp.pylsp.setup {
    on_attach = custom_attach,
    capabilities = capabilities
}

lsp.yamlls.setup {
    on_attach = custom_attach,
    capabilities = capabilities
}

lsp.vuels.setup {
    on_attach = custom_attach,
    capabilities = capabilities
}

lsp.texlab.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
    settings = {
        texlab = {
            build = {
                onSave = true,
                forwardSearchAfter = true,
                executable = "latexmk",
                args = {"-xelatex"},
            },
            --[[ forwardSearch = {
                executable = "okular",
                args = {"--unique", "file:%p#src:%l%f"}
            }, ]]
            lint = {onChange = true}
        }
    }
}

local null_ls = require('null-ls')

null_ls.config({
    sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.stylua.with({
            extra_args = {"--indent-type Spaces"}
        }),

        --[[
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.autopep8,
        --]]

        --null_ls.builtins.formatting.sqlformat,
        null_ls.builtins.diagnostics.shellcheck,
        --null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.diagnostics.hadolint,
        --null_ls.builtins.diagnostics.selene,
        null_ls.builtins.diagnostics.phpstan,
    },
})

lsp['null-ls'].setup({
    on_attach = custom_attach,
    capabilities = capabilities
})

require('symbols-outline').setup({
    highlight_hovered_item = true,
    show_guides = true
})

require("trouble").setup {
    icons = false,
    fold_open = "*",
    fold_closed = "-",
    indent_lines = true,
    use_lsp_diagnostic_signs = true,
    signs = {
        error = "[E]",
        warning = "[W]",
        hint = "?",
        information = "!",
        other = "`,:(",
    }
}

-- require 'lspinstall'.setup()

local M = {
    on_attach = custom_attach
}

function M.start_jdtls()
    --[[
    local home = os.getenv('HOME')
    local jar_patterns = {
        '/.lsp/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
    }

    local bundles = {}

    for _, jar_pattern in ipairs(jar_patterns) do
        for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
            table.insert(bundles, bundle)
        end
    end
    --]]

    local config = {
        cmd = {'java-jdtls.sh'},
        on_attach = custom_attach,
        capabilities = capabilities,
        --[[
        init_options = {
            bundles = bundles,
        }
        --]]
    }

    require('jdtls').start_or_attach(config)
end

-- Export my configuration to other modules just in case I need it elsewhere.
return M
