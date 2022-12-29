require('config.themes').setup()

local globals = require('globals')
local fzf = require('fzf-lua')
local Job = require('plenary.job')

-- Options
vim.opt.statusline = [[%!luaeval("require 'config.statusline'.status_line()")]]

-- Mappings

vim.keymap.set('n', '<C-f>', function()
    fzf.git_files()
end)
vim.keymap.set('n', '<M-f>', function()
    fzf.files()
end)
vim.keymap.set('n', '<C-s>', function()
    fzf.live_grep_native()
end)
vim.keymap.set('n', '<C-b>', function()
    fzf.buffers()
end)

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
vim.keymap.set('n', '<Leader>fm', function()
    Job:new {
        command = 'dbus-send',
        args = {
            '--session',
            '--dest=org.freedesktop.FileManager1',
            '--type=method_call',
            '/org/freedesktop/FileManager1',
            'org.freedesktop.FileManager1.ShowFolders',
            string.format([[array:string:file://%s]], vim.fn.expand('%:p:h')),
            string.format([[string:nvim-%s]], require 'lua-utils.prng'.randstr(6))
        }
    }:start()
end)
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

-- Iron
vim.keymap.set('x', '<Leader>is', '<Plug>(iron-visual-send)')
vim.keymap.set('n', '<Leader>is', '<Plug>(iron-send-line)')

-- MPD
vim.keymap.set('n', '<Leader>mm', function() require('mpd'):status() end)
vim.keymap.set('n', '<Leader>mp', function() require('mpd'):toggle() end)

-- Commands
vim.api.nvim_create_user_command('DefaultTheme', function()
    require('config.themes').set_default_theme()
end, {})

vim.api.nvim_create_user_command('PrettyTheme', function()
    require('config.themes').set_pretty_theme()
end, {})

vim.api.nvim_create_user_command('EditPlugin', function()
    local plugin_path = '~/.local/share/chezmoi/private_dot_config/nvim/pack/andry/start'
    vim.cmd("cd " .. plugin_path)
    fzf.files({ cwd = plugin_path })
end, {})

vim.api.nvim_create_user_command('EditDotfiles', function()
    local plugin_path = '~/.local/share/chezmoi'
    vim.cmd("cd " .. plugin_path)
    fzf.files({ cwd = plugin_path })
end, {})

vim.api.nvim_create_user_command('EnableAutoformat', function()
    globals.enable_autoformat(true)
end, {})

vim.api.nvim_create_user_command('DisableAutoformat', function()
    globals.enable_autoformat(false)
end, {})


local dap = require('dap')
local dapui = require('dapui')

vim.keymap.set('n', '<F4>', function()
    dap.continue()
end)

vim.keymap.set('n', '<F5>', function()
    dap.step_over()
end)

vim.keymap.set('n', '<F6>', function()
    dap.step_into()
end)

vim.keymap.set('n', '<F7>', function()
    dap.step_out()
end)

vim.keymap.set('n', '<Leader>db', function()
    dap.toggle_breakpoint()
end)

vim.keymap.set('n', '<Leader>dB', function()
    dap.set_breakpoint(vim.fn.input('When? '))
end)

vim.keymap.set('n', '<Leader>dr', function()
    dap.repl_open()
end)

vim.api.nvim_create_user_command('ToggleDebug', function()
    dapui.toggle()
end, {})

vim.api.nvim_create_user_command('NeotestRun', function()
    require('neotest').run.run()
end, {})

-- vim.api.nvim_create_autocmd('BufWritePost', {
--     group = vim.api.nvim_create_augroup("DotfilesSave", { clear = true }),
--     pattern = vim.env.HOME .. '/.local/share/chezmoi/*',
--     nested = true,
--     callback = function()
--         vim.cmd 'botright 5split | terminal chezmoi apply'
--     end
-- })

vim.opt.formatoptions:append 'cro'

vim.g.cmake_build_dir_location = 'build'
