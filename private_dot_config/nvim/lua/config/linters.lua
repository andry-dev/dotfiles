require("lint").linters_by_ft = {
    -- markdown = { "vale" },
    sh = { "shellcheck" },
    bash = { "shellcheck" },
    zsh = { "shellcheck" },
    python = { "ruff" },
    sql = { "sqruff" },
    -- tex = { "chktex" },
    elixir = { "credo" },
    systemd = { "systemdlint", "systemd-analyze" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require('lint').try_lint()
    end,
})
