if not pcall(require, 'vimp') then
    vim.cmd [[ echom 'Cannot load `vimp`' ]]
    return
end

vim.o.termguicolors = true

vim.g.nofrils_heavylinenumbers = 0
vim.g.nofrils_heavycomments = 1
vim.g.nofrils_strbackgrounds = 0
vim.g.gruvbox_contrast_light = 'hard'
vim.g.gruvbox_contrast_dark = 'hard'

-- Normal theme configuration
local default_theme_config = require'themes'.setup {
    daystart = 8,
    dayend = 19,
    light = 'nofrils-acme',
    dark = 'nofrils-dark'
}

-- Theme configuration for screenshots and such
local pretty_theme_config = require'themes'.setup {default_theme_config}

pretty_theme_config.dark = "moonfly"

pretty_theme_config.dark_fn = function()
    vim.o.background = "dark"
end

pretty_theme_config.light = "gruvbox"

pretty_theme_config.light_fn = function()
    vim.g.gruvbox_contrast_light = "hard"
    vim.o.background = "light"
end

local current_theme_config = default_theme_config
current_theme_config.set()

if not theme_timer then theme_timer = vim.loop.new_timer() end

function start_auto_theme()
    local minutes = 1
    theme_timer:start(0, minutes * 60 * 1000, vim.schedule_wrap(
                          function() current_theme_config.set() end))
end

function stop_theme_timer() theme_timer:stop() end

start_auto_theme()

function set_default_theme()
    current_theme_config = default_theme_config
    current_theme_config.set()
end

function set_pretty_theme()
    current_theme_config = pretty_theme_config
    current_theme_config.set()
end

function get_theme_config() return current_theme_config end

-- Options

vim.o.statusline = [[%!luaeval("require 'plugins/statusline'.status_line()")]]

-- Mappings

vimp.nnoremap('<C-f>', ':GFiles<CR>')
vimp.nnoremap('<M-f>', ':Files<CR>')
vimp.nnoremap('<C-s>', ':Rg<CR>')
vimp.nnoremap('<C-b>', ':Buffers<CR>')
vimp.nnoremap('<C-h>', '<C-w>h')
vimp.nnoremap('<C-j>', '<C-w>j')
vimp.nnoremap('<C-k>', '<C-w>k')
vimp.nnoremap('<C-l>', '<C-w>l')
vimp.nnoremap('Q', 'q')
vimp.cnoremap('Q', 'q')

vimp.nnoremap(';', ':')
vimp.nnoremap(':', ';')

vimp.nnoremap('j', 'gj')
vimp.nnoremap('k', 'gk')

vimp.nnoremap('<Left>', ':cprev<CR>')
vimp.nnoremap('<Right>', ':cnext<CR>')
vimp.nnoremap('<Up>', '<Nop>')
vimp.nnoremap('<Down>', '<Nop>')
vimp.nnoremap('h', '<Nop>')
vimp.nnoremap('l', '<Nop>')

vimp.nnoremap('cw', 'ciw')

vimp.inoremap('(<CR>', '(<CR>)<Esc>O')
vimp.inoremap('[<CR>', '[<CR>]<Esc>O')
vimp.inoremap('{<CR>', '{<CR>}<Esc>O')

vimp.inoremap({'expr'}, '<Tab>', function()
    if vim.fn.pumvisible() == 1 then
        return [[<C-n>]]
    else
        return [[<Tab>]]
    end
end)

vimp.inoremap({'expr'}, '<S-Tab>', function()
    if vim.fn.pumvisible() == 1 then
        return [[<C-p>]]
    else
        return [[<S-Tab>]]
    end
end)

vimp.nnoremap({'expr'}, '<CR>', function()
    vim.cmd [[nohlsearch]]
    return "<CR>"
end)

vimp.nnoremap({'silent'}, '<F1>', ':ExecUnderLine<CR>')
vimp.xnoremap({'silent'}, '<F1>', 'normal! :ExecSelection<CR>')
vimp.nnoremap('<Leader>se', ':silent! SetExecutableFlag<CR>')
vimp.nnoremap('<Leader>fm', ':Dispatch! dolphin %:p:h<CR>')
vimp.nnoremap('<F2>', ':Make<CR>')
vimp.nnoremap('<F3>',
              ':noautocmd vim /<FIND>/ **/* <Bar> cfdo %s//<REPLACE>/ce <Bar> wa')

vimp.tnoremap('<Esc>', [[<C-\><C-n>]])

if vim.fn.executable('rg') then
    vim.o.grepprg =
        "rg --vimgrep --no-heading --smart-case --no-ignore-vcs --ignore-file ~/.config/.ignore"
    vim.o.grepformat = '%f:%l:%c:%m,%f:%l:%m'
end

-- LSP
vimp.nnoremap('<leader>la', vim.lsp.buf.code_action)
vimp.nnoremap('<leader>lD', vim.lsp.buf.declaration)
vimp.nnoremap('<leader>ld', vim.lsp.buf.definition)
vimp.nnoremap('<leader>lr', vim.lsp.buf.rename)
vimp.nnoremap('<leader>lh', vim.lsp.buf.hover)
vimp.nnoremap('<leader>lH', vim.lsp.diagnostic.show_line_diagnostics)
vimp.nnoremap('<leader>li', vim.lsp.buf.implementation)
vimp.nnoremap('<leader>ls', vim.lsp.buf.signature_help)
vimp.nnoremap('<leader>lt', vim.lsp.buf.type_definition)
vimp.nnoremap('<leader>lx', vim.lsp.buf.references)
vimp.nnoremap('<leader>lS', vim.lsp.buf.document_symbol)
vimp.nnoremap('<leader>lw', vim.lsp.buf.workspace_symbol)
vimp.inoremap('<C-s>', vim.lsp.buf.signature_help)

-- vim-test
vimp.nnoremap({'silent'}, '<leader>tt', ':TestNearest<CR>')
vimp.nnoremap({'silent'}, '<leader>tf', ':TestFile<CR>')
vimp.nnoremap({'silent'}, '<leader>ta', ':TestSuite<CR>')

-- vimspector
vimp.nnoremap('<Leader>dc', ':call vimspector#Continue()<CR>')
vimp.nnoremap('<Leader>db', ':call vimspector#ToggleBreakpoint()<CR>')
vimp.nnoremap('<Leader>dn', ':call vimspector#StepOver()<CR>')
vimp.nnoremap('<Leader>ds', ':call vimspector#StepInto()<CR>')
vimp.nnoremap('<Leader>do', ':call vimspector#StepOut()<CR>')
vimp.nnoremap('<Leader>dr', ':call vimspector#Restart()<CR>')

-- Iron
vimp.xnoremap('<Leader>is', '<Plug>(iron-visual-send)')
vimp.nnoremap('<Leader>is', '<Plug>(iron-send-line)')
