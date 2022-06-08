local globals = require 'globals'

local lsp = require 'lspconfig'
-- local configs = require 'lspconfig/configs'


-- require('lsp_signature').on_attach()

-- TODO(andry, 2021-01-04): This is actually bad tbh.
-- Maybe refactor it to something better?

function should_format()
    if globals.autoformat_enabled() then vim.lsp.buf.formatting() end
end

local function add_if_executable_exists(lsp_name, executable, config)
    if vim.fn.executable(executable) == 1 then
        lsp[lsp_name].setup(config)
    end
end

vim.lsp.handlers["textDocument/formatting"] =
    function(err, result, context, _)
        if err ~= nil or result == nil then return end
        if not vim.api.nvim_buf_get_option(context.bufnr, "modified") then
            local view = vim.fn.winsaveview()
            vim.lsp.util.apply_text_edits(result, context.bufnr, vim.opt.fileencoding:get())
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

local default_config = {
    on_attach = custom_attach,
    capabilities = capabilities
}

function default_config:with(new_options)
    return vim.tbl_extend("force", self, new_options)
end

-- I specify all language serviers here and they will be conditionally enabled if the executable exists
-- This prevents annoying issues in new machines when a language server is not configured
local language_servers = {
    clangd = {
        executable = 'clangd',
        config = default_config:with {
            cmd = {
                "clangd", "--background-index", "--cross-file-rename", "--clang-tidy",
                "--recovery-ast"
            }
        }
    },

    cmake = {
        executable = 'cmake-language-server',
        config = default_config
    },

    solargraph = {
        executable = 'solargraph',
        config = default_config
    },

    html = {
        executable = 'html-languageserver',
        config = default_config
    },

    cssls = {
        executable = 'css-languageserver',
        config = default_config
    },


    intelephense = {
        executable = 'intelephense',
        config = default_config
    },

    sqlls = {
        executable = 'sql-language-server',
        config = default_config:with {
            cmd = {'sql-language-server', 'up', '--method', 'stdio'}
        }
    },

    pylsp = {
        executable = 'pylsp',
        config = default_config
    },

    yamlls = {
        executable = 'yaml-language-server',
        config = default_config
    },


    vuels = {
        executable = 'vue-language-server',
        config = default_config
    },

    terraformls = {
        executable = 'terraform-ls',
        config = default_config
    },

    --[[
    texlab = {
        executable = 'texlab',
        config = default_config:with {
            cmd = {'texlab', '-vvvv', '--log-file', '/tmp/texlab.log'},
            settings = {
                texlab = {
                    build = {
                        executable = 'latexmk',
                        args = {'-verbose', '-synctex=1', '-pvc'},
                        forwardSearchAfter = true,
                        forwardSearch = {
                            executable = "zathura",
                            args = {
                                "--synctex-forward",
                                "%l:1:%f",
                                "%p"
                            },
                        },
                        onSave = true,
                    },
                }
            },
        }
    },
    --]]
}

for name, info in pairs(language_servers) do
    add_if_executable_exists(name, info.executable, info.config)
end

lsp.elixirls.setup(default_config:with {
    root_dir = lsp.util.root_pattern(".git", "mix.exs"),
    cmd = {globals.elixirls_basepath .. '/release/language_server.sh'}
})

require('nlua.lsp.nvim').setup(lsp, default_config:with {
    cmd = {globals.sumneko_binary, "-E", globals.sumneko_basepath .. "/main.lua"},
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


local null_ls = require('null-ls')

local null_ls_sources = { sources = {} }

function null_ls_sources:add(executable, source)
    if vim.fn.executable(executable) == 1 then
        vim.list_extend(self.sources, {source})
    end
end

null_ls_sources:add('prettier', null_ls.builtins.formatting.prettier)
null_ls_sources:add('stylua', null_ls.builtins.formatting.stylua.with({
    extra_args = {"--indent-type Spaces"}
}))
null_ls_sources:add('shellcheck', null_ls.builtins.diagnostics.shellcheck)
null_ls_sources:add('eslint_d', null_ls.builtins.diagnostics.eslint_d)
null_ls_sources:add('hadolint', null_ls.builtins.diagnostics.hadolint)
null_ls_sources:add('phpstan', null_ls.builtins.diagnostics.phpstan)

null_ls.setup({

    sources = null_ls_sources.sources,
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
    use_diagnostic_signs = true,
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
