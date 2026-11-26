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
            exclude = { "rust_analyzer", "beancount", "ansible-lint", "elixir-ls" }
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
            "kdlfmt",
        },
    })
end
