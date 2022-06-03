require('config.themes').setup()

-- Options
vim.opt.statusline = [[%!luaeval("require 'config.statusline'.status_line()")]]

-- Mappings
vim.keymap.set('n', '<C-f>', ':GFiles<CR>')
vim.keymap.set('n', '<M-f>', ':Files<CR>')
vim.keymap.set('n', '<C-s>', ':Rg<CR>')
vim.keymap.set('n', '<C-b>', ':Buffers<CR>')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', 'Q', 'q')

vim.keymap.set('n', ';', ':')
vim.keymap.set('n', ':', ';')

vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

vim.keymap.set('n', '<Left>', ':cprev<CR>')
vim.keymap.set('n', '<Right>', ':cnext<CR>')
vim.keymap.set('n', '<Up>', '<Nop>')
vim.keymap.set('n', '<Down>', '<Nop>')
vim.keymap.set('n', 'h', '<Nop>')
vim.keymap.set('n', 'l', '<Nop>')

vim.keymap.set('n', 'cw', 'ciw')

vim.keymap.set('i', '(<CR>', '(<CR>)<Esc>O')
vim.keymap.set('i', '[<CR>', '[<CR>]<Esc>O')
vim.keymap.set('i', '{<CR>', '{<CR>}<Esc>O')

vim.keymap.set('n', '<CR>', function()
    vim.cmd [[nohlsearch]]
    return "<CR>"
end, { expr = true, silent = true })

vim.keymap.set('n', '<F1>', ':ExecUnderLine<CR>', { silent = true })
vim.keymap.set('x', '<F1>', 'normal! :ExecSelection<CR>', { silent = true })
vim.keymap.set('n', '<Leader>se', ':silent! SetExecutableFlag<CR>')
vim.keymap.set('n', '<Leader>fm', ':Dispatch! dolphin %:p:h<CR>')
vim.keymap.set('n', '<F2>', ':Make<CR>')
vim.keymap.set('n', '<F3>', ':noautocmd vim /<FIND>/ **/* <Bar> cfdo %s//<REPLACE>/ce <Bar> wa')

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

if vim.fn.executable('rg') then
    vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case --no-ignore-vcs --ignore-file ~/.config/.ignore"
    vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
end

-- LSP
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration)
vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>lH', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation)
vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition)
vim.keymap.set('n', '<leader>lx', vim.lsp.buf.references)
vim.keymap.set('n', '<leader>lS', vim.lsp.buf.document_symbol)
vim.keymap.set('n', '<leader>lw', vim.lsp.buf.workspace_symbol)
vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help)

-- vim-test
vim.keymap.set('n', '<leader>tt', ':TestNearest<CR>', { silent = true })
vim.keymap.set('n', '<leader>tf', ':TestFile<CR>', { silent = true })
vim.keymap.set('n', '<leader>ta', ':TestSuite<CR>', { silent = true })

-- vimspector
vim.keymap.set('n', '<Leader>dc', ':call vimspector#Continue()<CR>')
vim.keymap.set('n', '<Leader>db', ':call vimspector#ToggleBreakpoint()<CR>')
vim.keymap.set('n', '<Leader>dn', ':call vimspector#StepOver()<CR>')
vim.keymap.set('n', '<Leader>ds', ':call vimspector#StepInto()<CR>')
vim.keymap.set('n', '<Leader>do', ':call vimspector#StepOut()<CR>')
vim.keymap.set('n', '<Leader>dr', ':call vimspector#Restart()<CR>')

-- Iron
vim.keymap.set('x', '<Leader>is', '<Plug>(iron-visual-send)')
vim.keymap.set('n', '<Leader>is', '<Plug>(iron-send-line)')

-- MPD
vim.keymap.set('n', '<Leader>mm', function() require('mpd'):status() end)
vim.keymap.set('n', '<Leader>mp', function() require('mpd'):toggle() end)
