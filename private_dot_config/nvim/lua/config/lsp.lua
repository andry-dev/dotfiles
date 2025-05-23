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
            -- "proselint",
            -- "textlint",
            -- "write-good",
            -- "vale",
            "hadolint",
            "codespell",
            "luacheck",
            "systemdlint",
            "shellcheck",
            "ruff",
            "sqruff",
            "shfmt",
        },
    })
end

local globals = require('globals')

-- local lsp = require("lspconfig")
-- lsp.util.default_config.on_init = function(client, _)
--     client.server_capabilities.semanticTokensProvider = nil
-- end

vim.g.disable_autoformat = false


local custom_attach = function(client)
    -- client.server_capabilities.semanticTokensProvider = nil
end

---@param completion_framework andry.CompletionFramework
local make_default_capabilities = function(completion_framework)
    local def_caps = vim.lsp.protocol.make_client_capabilities()

    if completion_framework == globals.CompletionFramework.Blink then
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

vim.lsp.config('*', {
    capabilities = default_config.capabilities,
})

vim.lsp.config('beancount', {
    root_markers = {},
    settings = {
        journal_file = vim.fn.expand('~/Sync/beancount/main.beancount')
    }
})

vim.lsp.config('clangd', {
    config = {
        cmd = {
            "clangd",
            "--background-index",
            "--cross-file-rename",
            "--clang-tidy",
            "--recovery-ast",
        },
    }
})

vim.lsp.config('jsonls', {
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    },
})

vim.lsp.config('yamlls', {
    settings = {
        yaml = {
            schemaStore = {
                enable = false,
                url = "",
            },

            schemas = require("schemastore").yaml.schemas(),
        },
    },
})

vim.lsp.config('texlab', {
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
    }
})

vim.lsp.config('ltex_plus', {
    on_attach = function(client)
        custom_attach(client)
        require("ltex_extra").setup({
            load_langs = { 'it', 'en-US' },
            path = ".ltex",
        })
    end,

    settings = {
        ltex = {
            completionEnabled = true,

            additionalRules = {
                enablePickyRules = true,
                motherTongue = "it",
                languageModel = vim.g.ltex_ngrams or "~/.local/share/ngrams"
            },

            enabledRules = {
                en = {
                    "IT_IS_OBVIOUS",
                    "E_PRIME_STRICT",
                    "HOPEFULLY",
                    "CHILDISH_LANGUAGE",
                    "USED_FOR_VBG",
                    "USELESS_THAT",
                },

                it = {
                    "GR_01_001",
                    "GR_02_001",
                    "GR_03",
                    "GR_04_002",
                    "GR_05",
                    "GR_05_002",
                    "GR_09",
                    "GR_10_001",
                    "ST_02",
                    "ST_02_001",
                    "ST_03",
                    "ST_03_002",
                    "ST_04",
                    "ST_04_001",
                    "ST_04_002",
                    "ER_01",
                    "ER_01_004",
                    "ER_02",
                    "ER_02_002",
                    "ER_02_003",
                    "NUMBER_DAYS_MONTH",
                },
            },
        }
    }
})

vim.lsp.enable({
    'ansiblels',
    'basedpyright',
    'bashls',
    'beancount',
    'clangd',
    'cmake',
    'cssls',
    'emmet_language_server',
    'eslint',
    'gopls',
    'html',
    'intelephense',
    'jsonls',
    'ltex_plus',
    'nil_ls',
    'sqlls',
    'systemd_ls',
    'texlab',
    'ts_ls',
    'yamlls',
})

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

require("conform").setup({
    formatters_by_ft = {
        python = { "ruff" },

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

local lint = require("lint")
lint.linters_by_ft = {
    -- markdown = { "vale" },
    sh = { "shellcheck" },
    bash = { "shellcheck" },
    zsh = { "shellcheck" },
    python = { "ruff" },
    sql = { "sqruff" },
    tex = { "chktex" },
    elixir = { "credo" },
    systemd = { "systemdlint", "systemd-analyze" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        lint.try_lint()
    end,
})

-- Try to disable LSP semantic tokens.
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    callback = function()
        for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
            vim.api.nvim_set_hl(0, group, {})
        end
    end
})


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
        capabilities = default_config.capabilities,
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
