if vim.g.mason_enabled then
    -- Sometimes I install tooling from `nix` or similar sources.
    -- In such cases, I don't need to override them with Mason.
    -- local exclude_existing = function()
    --     local executables = { "rust_analyzer", "beancount", "ansible-lint" }
    --
    --     local ret = {}
    --
    --     for _, exec in pairs(executables) do
    --         if vim.fn.executable(exec) == 1 then
    --             print("Executable: " .. exec)
    --             table.insert(ret, exec)
    --         end
    --     end
    --
    --     P(ret)
    --
    --     return ret
    -- end

    require("mason-lspconfig").setup({
        ensure_installed = { "zk", },
        automatic_installation = {
            -- exclude = exclude_existing(),
            exclude = { "rust_analyzer", "beancount", "ansible-lint" }
        },
    })

    require("mason-tool-installer").setup({
        ensure_installed = {
            "shellcheck",
            "proselint",
            "textlint",
            "write-good",
            "vale",
            "hadolint",
            "codespell",
            "luacheck",
        },
    })
end

local globals = require('globals')

local lsp = require("lspconfig")

vim.g.disable_autoformat = false

require("conform").setup({
    formatters_by_ft = {
        python = { "isort", "autopep8" },

        cmake = { "cmake_format" },
        c = { "clang_format" },
        cpp = { "clang_format" },

        rust = { "rustfmt" },

        javascript = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },

        sh = { "shfmt", "shellcheck", stop_after_first = true },
        bash = { "shfmt", "shellcheck", stop_after_first = true },
        yaml = { "yamlfmt" },

        go = { "goimports", "gofumpt", "gofmt" },

        just = { "just" },

        latex = { "latexindent" },

        nix = { "alejandra" },

        -- Use the "*" filetype to run formatters on all filetypes.
        ["*"] = (not vim.g.prefers_energy_efficiency and { "codespell" }) or {},
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = (not vim.g.prefers_energy_efficiency and { "trim_whitespace" }) or {},
    },

    format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end

        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match("/node_modules/") then
            return
        end

        return { timeout_ms = 500, lsp_fallback = true }
    end,
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

local custom_attach = function(_client)
    -- require('lsp_signature').on_attach()
    -- require('virtualtypes').on_attach()
    -- if client.server_capabilities.documentFormattingProvider then
    --     vim.cmd [[augroup Format]]
    --     vim.cmd [[autocmd! * <buffer>]]
    --     vim.cmd [[autocmd BufWritePost <buffer> lua should_format()]]
    --     vim.cmd [[augroup END]]
    -- end
end

---@param completion_framework andry.CompletionFramework
local make_default_capabilities = function(completion_framework)
    local def_caps = vim.lsp.protocol.make_client_capabilities()

    if completion_framework == globals.CompletionFramework.NvimCmp then
        return vim.tbl_deep_extend('force', def_caps, require("cmp_nvim_lsp").default_capabilities())
    elseif completion_framework == globals.CompletionFramework.Blink then
        return require("blink.cmp").get_lsp_capabilities(def_caps)
    end

    return def_caps
end

local default_config = {
    on_attach = custom_attach,
    capabilities = make_default_capabilities(vim.g.completion_framework),
}

function default_config:with(new_options)
    return vim.tbl_extend("force", self, new_options)
end

-- I specify all language servers here and they will be conditionally enabled if the executable exists
-- This prevents annoying issues in new machines when a language server is not configured
local language_servers = {
    ansiblels = {
        executable = "ansiblels",
        config = default_config,
    },

    emmet_language_server = {
        config = default_config
    },

    beancount = {
        config = default_config:with({
            init_options = {
                journalFile = "~/Sync/beancount/main.beancount",
            }
        }),
    },

    clangd = {
        executable = "clangd",
        config = default_config:with({
            cmd = {
                "clangd",
                "--background-index",
                "--cross-file-rename",
                "--clang-tidy",
                "--recovery-ast",
            },
        }),
    },

    cmake = {
        executable = "cmake-language-server",
        config = default_config,
    },

    eslint = {
        executable = "eslint",
        config = default_config,
    },

    -- elixirls = {
    --     executable = "elixir_ls",
    --     config = default_config:with({
    --         root_dir = lsp.util.root_pattern(".git", "mix.exs"),
    --     }),
    -- },

    html = {
        executable = "html-languageserver",
        config = default_config,
    },

    cssls = {
        executable = "css-languageserver",
        config = default_config,
    },

    ts_ls = {
        config = default_config,
    },

    intelephense = {
        executable = "intelephense",
        config = default_config,
    },

    sqlls = {
        executable = "sql-language-server",
        config = default_config:with({
            cmd = { "sql-language-server", "up", "--method", "stdio" },
        }),
    },

    pylsp = {
        executable = "pylsp",
        config = default_config,
    },

    jsonls = {
        config = default_config:with({
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                    validate = { enable = true },
                },
            },
        }),
    },

    yamlls = {
        executable = "yaml-language-server",
        config = default_config:with({
            settings = {
                yaml = {
                    schemaStore = {
                        enable = false,
                        url = "",
                    },

                    schemas = require("schemastore").yaml.schemas(),
                },
            },
        }),
    },

    vuels = {
        executable = "vue-language-server",
        config = default_config,
    },

    solidity = {
        executable = "solidity-ls",
        config = default_config,
    },

    terraformls = {
        executable = "terraform-ls",
        config = default_config,
    },


    texlab = {
        config = default_config:with({
            -- cmd = { vim.fn.stdpath('data') .. '/mason/bin/texlab', '-vvvv', '--log-file', '/tmp/texlab.log' },
            -- on_new_config = function(new_config, new_root_dir)
            --     new_config.settings.texlab.rootDirectory = new_root_dir
            -- end,
            settings = {
                texlab = {
                    build = {
                        executable = "latexmk",
                        args = { "-verbose", "-synctex=1", "-interaction=nonstopmode", "-pv" },
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
                },
            },
        }),
    },

    gopls = {
        config = default_config,
    },

    nil_ls = {
        config = default_config,
    },
}

if not vim.g.prefers_energy_efficiency then
    lsp["ltex"] = {
        config = default_config:with({
            on_attach = function(client)
                custom_attach(client)
                -- require("ltex_extra").setup({
                --     load_langs = { "en-US", "it" }
                -- })
            end,

            settings = {
                ltex = {
                    completionEnabled = true,
                    additionalRules = {
                        enablePickyRules = true,
                        motherTongue = "it",
                        languageModel = vim.g.ltex_ngrams or "~/.local/share/ngrams"
                    }
                }
            }
        })
    }
end

for name, info in pairs(language_servers) do
    lsp[name].setup(info.config)
end

lsp.lua_ls.setup(default_config:with({}))

require('elixir').setup({
    elixirls = {
        settings = require('elixir.elixirls').settings {
            dialyzerEnabled = true,
            fetchDeps = true,
            enableTestLenses = true,
            suggestSpecs = true,
        }
    },
})

if not vim.g.prefers_energy_efficiency then
    require("ltex_extra").setup({
        load_langs = { 'it', 'en-US' },
        path = ".ltex",
    })
end

local lint = require("lint")
lint.linters_by_ft = {
    -- markdown = { "vale" },
    tex = { "chktex" },
    elixir = { "credo" },
    lua = { "luacheck" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        lint.try_lint()
    end,
})

-- require("symbols-outline").setup({
--     highlight_hovered_item = true,
--     show_guides = true,
-- })

-- require("trouble").setup({
--     fold_open = "*",
--     fold_closed = "-",
--     indent_lines = true,
--     use_diagnostic_signs = true,
--     signs = {
--         error = "[E]",
--         warning = "[W]",
--         hint = "?",
--         information = "!",
--         other = "`,:(",
--     },
-- })

-- require 'lspinstall'.setup()

---@class andry.LspConfig
local M = {
    on_attach = custom_attach,
    capabilities = default_config.capabilities,
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
        cmd = { "java-jdtls.sh" },
        on_attach = custom_attach,
        capabilities = capabilities,
        --[[
        init_options = {
            bundles = bundles,
        }
        --]]
    }

    require("jdtls").start_or_attach(config)
end

-- Export my configuration to other modules just in case I need it elsewhere.
return M
