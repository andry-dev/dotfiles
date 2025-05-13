-- vim.wo.conceallevel = 0
vim.wo.spell = true

if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
    local function map(...) vim.api.nvim_buf_set_keymap(0, ...) end

    local opts = { noremap = true, silent = false }

    -- Open the link under the caret.
    map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)

    map("n", "<C-f>", "<Cmd>ZkNotes<CR>", opts)
    map("i", "<C-f>", "<Cmd>ZkInsertLink<CR>", opts)
    map("v", "<C-f>", ":'<,'>ZkInsertLinkAtSelection<CR>", opts)

    map("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)

    -- Create a new note after asking for its title.
    -- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
    map("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
    -- Create a new note in the same directory as the current buffer, using the current selection for title.
    map("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", opts)
    -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
    map("v", "<leader>znc",
        ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)


    -- Open notes linking to the current buffer.
    map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)
    -- Alternative for backlinks using pure LSP and showing the source context.
    --map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- Open notes linked by the current buffer.
    map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)
end
