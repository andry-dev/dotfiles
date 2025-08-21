vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.g.disable_autoformat = false

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

        -- latex = { "latexindent" },

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
