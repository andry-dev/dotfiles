vim.cmd.filetype('plugin indent on')

local function is_device_low_powered()
    local known_devices = { 'aya', 'shiki' }
    local hostname = vim.fn.hostname()

    return vim.tbl_contains(known_devices, hostname)
end

vim.g.mapleader = ','

local globals = require('globals')

vim.g.prefers_energy_efficiency = is_device_low_powered()
vim.g.mason_enabled = os.getenv("NVIM_USE_NIX") == nil

---@type andry.CompletionFramework
vim.g.completion_framework = globals.CompletionFramework.Blink

if vim.g.neovide then
    vim.g.neovide_position_animation_length = 0
    vim.g.neovide_cursor_animation_length = 0.00
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_scroll_animation_far_lines = 0
    vim.g.neovide_scroll_animation_length = 0.00

    vim.opt.guifont = "Pragmasevka:h16"
    if not vim.g.prefers_energy_efficiency then
        vim.g.neovide_refresh_rate = 144
    end
end


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local base_plugin_path = vim.fn.stdpath('config') .. '/pack/andry/start/'

require("lazy").setup('plugins', {
    dev = {
        path = '~/prj'
    },
    performance = {
        rtp = {
            paths = {
                base_plugin_path .. 'focus',
                base_plugin_path .. 'lua-utils',
                base_plugin_path .. 'auto-themes'
            }
        }
    },
    ui = {
        icons = {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
})

-- require('plugins')
require('focus').setup()

vim.g.netrw_liststype = 3
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 1

vim.g.cmake_link_compile_commands = 1
vim.g.cmake_generate_options = { '-G Ninja' }

vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.cmake_build_dir_location = 'build'


local Job = require('plenary.job')
local globals = require('globals')
local fzf = require('fzf-lua')

vim.opt.wildmenu = true
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.inccommand = 'split'
vim.opt.gdefault = true
vim.opt.undofile = true
vim.opt.hidden = true
vim.opt.spelllang = 'en,it,cjk'
vim.opt.mouse = 'a'
vim.opt.listchars = 'tab:> ,nbsp:!,trail:.'
vim.opt.list = true
vim.opt.colorcolumn = '80,120'
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false
vim.opt.foldlevelstart = 99
vim.opt.cpoptions:append('J')
vim.opt.formatoptions:append('p')
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.ts = 4
vim.opt.sts = 4
vim.opt.sw = 4
vim.opt.expandtab = true
vim.opt.updatetime = 1000
vim.opt.dictionary:append('/usr/share/hunspell/en_GB.dic')
vim.opt.dictionary:append('/usr/share/hunspell/it_IT.dic')
vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
vim.opt.statusline = [[%!luaeval("require 'config.statusline'.status_line()")]]
vim.opt.formatoptions:append('cro')

if vim.fn.executable('rg') then
    vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case --no-ignore-vcs --ignore-file ~/.config/.ignore"
    vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
end

-- Misc functions

local function enableTSHighlight()
    require('nvim-treesitter.configs').commands.TSEnable.run('highlight')
end

local function disableTSHighlight()
    require('nvim-treesitter.configs').commands.TSDisable.run('highlight')
end

local function set_pretty_theme()
    require('config.themes').set_pretty_theme()
    enableTSHighlight()
end

local function set_default_theme()
    require('config.themes').set_default_theme()
    disableTSHighlight()
end


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

vim.keymap.set('i', '<C-u>', '<Nop>')

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
vim.keymap.set('n', '<leader>tt', function()
    require('neotest').run.run()
end, { silent = true })
vim.keymap.set('n', '<leader>tf', function()
    require('neotest').run.run(vim.fn.expand('%'))
end, { silent = true })
vim.keymap.set('n', '<leader>ts', function()
    require('neotest').summary.toggle()
end, { silent = true })

-- Iron
vim.keymap.set('x', '<Leader>is', '<Plug>(iron-visual-send)')
vim.keymap.set('n', '<Leader>is', '<Plug>(iron-send-line)')

-- MPD
vim.keymap.set('n', '<Leader>mm', function() require('mpd'):status() end)
vim.keymap.set('n', '<Leader>mp', function() require('mpd'):toggle() end)

-- Commands
vim.api.nvim_create_user_command('DefaultTheme', function()
    require('config.themes').set_default_theme()
    disableTSHighlight()
end, {})

vim.api.nvim_create_user_command('PrettyTheme', function()
    require('config.themes').set_pretty_theme()
    enableTSHighlight()
end, {})

vim.api.nvim_create_user_command('EditPlugin', function()
    local plugin_path = '~/.local/share/chezmoi/private_dot_config/nvim'
    fzf.files({ cwd = plugin_path })
    vim.cmd.lcd(plugin_path)
end, {})

vim.api.nvim_create_user_command('EditDotfiles', function()
    local plugin_path = '~/.local/share/chezmoi'
    fzf.files({ cwd = plugin_path })
    vim.cmd.lcd(plugin_path)
end, {})

vim.api.nvim_create_user_command('EnableAutoformat', function()
    globals.enable_autoformat(true)
end, {})

vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
    else
        vim.g.disable_autoformat = true
    end
end, {
    desc = "Disable autoformat-on-save",
    bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
end, {
    desc = "Re-enable autoformat-on-save",
})


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

vim.api.nvim_create_user_command('NeotestSummary', function()
    require('neotest').summary.toggle()
end, {})

vim.api.nvim_create_user_command('NeotestFileRun', function()
    require('neotest').run.run(vim.fn.expand('%'))
end, {})

vim.api.nvim_create_user_command('DisableThemeTimer', function()
    require('config.themes').stop_timer()
end, {})

vim.api.nvim_create_user_command('EnableThemeTimer', function()
    require('config.themes').start_timer()
end, {})

-- vim.api.nvim_create_autocmd('BufWritePost', {
--     group = vim.api.nvim_create_augroup("DotfilesSave", { clear = true }),
--     pattern = vim.env.HOME .. '/.local/share/chezmoi/*',
--     nested = true,
--     callback = function()
--         vim.cmd 'botright 5split | terminal chezmoi apply'
--     end
-- })

vim.api.nvim_create_user_command('SetExecutableFlag', function()
    local file = vim.fn.expand('%')
    Job:new({
        command = 'git',
        args = { 'add', '-f', file }
    }):sync()

    Job:new({
        command = 'git',
        args = { 'update-index', '--chmod=+x', file }
    }):sync()

    Job:new({
        command = 'chmod',
        args = { '+x', file }
    }):sync()
end, {})

vim.api.nvim_create_user_command('SetupForScreens', function()
    local lang = vim.v.lang
    local spell = vim.opt.spell:get()

    vim.cmd.language("en_US.UTF-8")
    vim.opt.spell = false

    set_pretty_theme()

    vim.cmd.redraw()
    vim.fn.getchar()

    set_default_theme()

    vim.cmd.language(lang)
    vim.opt.spell = spell
end, {})

vim.opt.exrc = true
vim.opt.secure = true
