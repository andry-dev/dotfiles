local globals = require 'globals'

require('mason-lspconfig').setup({
    automatic_installation = {
        exclude = { "rust_analyzer" }
    },
})

local lsp = require 'lspconfig'

function should_format()
    if globals.autoformat_enabled() then vim.lsp.buf.format({ async = true }) end
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
    if client.server_capabilities.documentFormattingProvider then
        vim.cmd [[augroup Format]]
        vim.cmd [[autocmd! * <buffer>]]
        vim.cmd [[autocmd BufWritePost <buffer> lua should_format()]]
        vim.cmd [[augroup END]]
    end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
    ansiblels = {
        executable = 'ansiblels',
        config = default_config,
    },

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

    eslint = {
        executable = 'eslint',
        config = default_config,
    },

    elixirls = {
        executable = 'elixir_ls',
        config = default_config:with {
            root_dir = lsp.util.root_pattern(".git", "mix.exs"),
        }
    },

    -- solargraph = {
    --     executable = 'solargraph',
    --     config = default_config
    -- },

    html = {
        executable = 'html-languageserver',
        config = default_config
    },

    cssls = {
        executable = 'css-languageserver',
        config = default_config
    },

    denols = {
        config = default_config
    },

    intelephense = {
        executable = 'intelephense',
        config = default_config
    },

    sqlls = {
        executable = 'sql-language-server',
        config = default_config:with {
            cmd = { 'sql-language-server', 'up', '--method', 'stdio' }
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

    solidity = {
        executable = 'solidity-ls',
        config = default_config
    },

    terraformls = {
        executable = 'terraform-ls',
        config = default_config
    },

    texlab = {
        config = default_config:with {
            -- cmd = { vim.fn.stdpath('data') .. '/mason/bin/texlab', '-vvvv', '--log-file', '/tmp/texlab.log' },
            -- on_new_config = function(new_config, new_root_dir)
            --     new_config.settings.texlab.rootDirectory = new_root_dir
            -- end,
            settings = {
                texlab = {
                    build = {
                        executable = 'latexmk',
                        args = { '-verbose', '-synctex=1', '-interaction=nonstopmode', '-pv' },
                        -- forwardSearchAfter = true,
                        onSave = true,
                    },
                    -- forwardSearch = {
                    --     executable = 'evince-synctex',
                    --     args = {
                    --         '-f',
                    --         '%l',
                    --         '%p',
                    --         '/usr/bin/true'
                    --     },
                    -- },
                }
            },
        }
    },

    gopls = {
        config = default_config
    },

    nil_ls = {
        config = default_config
    }
}


local function setup_efm()
    local shellcheck = require('efmls-configs.linters.shellcheck')
    local proselint = require('efmls-configs.linters.proselint')
    local textlint = require('efmls-configs.linters.textlint')
    local write_good = require('efmls-configs.linters.write_good')

    local ansible_lint = require('efmls-configs.linters.ansible_lint')


    local languages = require('efmls-configs.defaults').languages()
    languages = vim.tbl_extend('force', languages, {
        text = { proselint, textlint, write_good },
        tex = { proselint, textlint, write_good },
        markdown = { proselint, textlint, write_good },

        sh = { shellcheck },
        bash = { shellcheck },
        zsh = { shellcheck },

        yaml = {
            ansible_lint
        }
    })

    local efmls_config = {
        filetypes = vim.tbl_keys(languages),
        settings = {
            rootMarkers = { '.git/' },
            languages = languages,
        },
        init_options = {
            documentFormatting = true,
            docuemntRangeFormatting = true
        }
    }

    language_servers.efm = {
        config = default_config:with(efmls_config)
    }
end

setup_efm()

for name, info in pairs(language_servers) do
    lsp[name].setup(info.config)
end

require('neodev').setup()

lsp.lua_ls.setup(default_config:with {})


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
        cmd = { 'java-jdtls.sh' },
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
