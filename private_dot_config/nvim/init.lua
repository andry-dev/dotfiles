vim.cmd.filetype('plugin indent on')

local globals = require('globals')

vim.g.prefers_energy_efficiency = globals.is_device_low_powered()
vim.g.is_discharging = false
vim.g.mason_enabled = os.getenv("NVIM_USE_NIX") == nil

---@type andry.CompletionFramework
vim.g.completion_framework = globals.CompletionFramework.Blink


vim.g.mapleader = ','

(function()
    ---@type system_events.Config
    vim.g.system_events = {
        sleep_delay = 1,
        listeners = {
            power = true,
        }
    }

    local group = vim.api.nvim_create_augroup('MyPowerStateChanged', { clear = true })

    vim.api.nvim_create_autocmd('User', {
        pattern = 'PowersaveStateChanged',
        group = group,
        callback = function(powersave_enabled)
            vim.g.prefers_energy_efficiency = powersave_enabled.data
        end,
    })

    vim.api.nvim_create_autocmd('User', {
        pattern = 'ACStatusChanged',
        group = group,
        callback = function(data)
            local event = data.data
            local types = require('system_events.types')
            vim.g.is_discharging = (event.device_type == types.ACDevice.Battery) and
                (event.status == types.BatteryStatus.Discharging)
        end,
    })
end)()

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
        path = '~/prj/anri',
        patterns = { 'andry-dev' },
        fallback = true,
    },

    performance = {
        rtp = {
            paths = {
                base_plugin_path .. 'lua-utils',
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


vim.g.anri = {
    keymaps = {
        CodeAction = '<leader>la',
        Definition = '<leader>ld',
        Declaration = '<leader>lD',
        Rename = '<leader>lr',
        Hover = '<leader>lh',
        Diagnostic = '<leader>lH',
        Implementation = '<leader>li',
        References = '<leader>lx',
        DocumentSymbol = '<leader>lS',
        WorkspaceSymbol = '<leader>lw',
    }
}


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

vim.g.netrw_liststype = 3
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 1

vim.g.cmake_link_compile_commands = 1
vim.g.cmake_generate_options = { '-G Ninja' }

vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.cmake_build_dir_location = 'build'


local Job = require('plenary.job')
local fzf = require('fzf-lua')

vim.o.wildmenu = true
vim.o.hlsearch = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.inccommand = 'split'
vim.o.gdefault = true
vim.o.undofile = true
vim.o.hidden = true
vim.o.spelllang = 'en,it,cjk'
vim.o.listchars = 'tab:> ,nbsp:!,trail:.'
vim.o.list = true
vim.o.colorcolumn = '80,120'
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldenable = false
vim.o.foldlevelstart = 99
vim.o.cpoptions = table.concat({ vim.o.cpoptions, 'J' })
vim.o.formatoptions = table.concat({ vim.o.formatoptions, 'p' })
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.ts = 4
vim.o.sts = 4
vim.o.sw = 4
vim.o.expandtab = true
vim.o.updatetime = 1000
vim.o.mouse = 'a'
vim.go.mouse = 'a'

if vim.fn.has('unix') == 1 then
    vim.opt.dictionary:append('/usr/share/hunspell/en_GB.dic')
    vim.opt.dictionary:append('/usr/share/hunspell/it_IT.dic')
end

vim.o.statusline = [[%!luaeval("require 'config.statusline'.status_line()")]]
vim.opt.formatoptions:append('cro')

if vim.fn.executable('rg') then
    vim.o.grepprg = "rg --vimgrep --no-heading --smart-case --no-ignore-vcs --ignore-file ~/.config/.ignore"
    vim.o.grepformat = '%f:%l:%c:%m,%f:%l:%m'
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

-- vim.keymap.set('i', '(<CR>', '(<CR>)<Esc>O')
-- vim.keymap.set('i', '[<CR>', '[<CR>]<Esc>O')
-- vim.keymap.set('i', '{<CR>', '{<CR>}<Esc>O')

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

vim.keymap.set('n', vim.g.anri.keymaps.Diagnostic, vim.diagnostic.open_float)

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local kmaps = vim.g.anri.keymaps

        vim.keymap.set({ 'v', 'n' }, kmaps.CodeAction, vim.lsp.buf.code_action, { buffer = true })
        vim.keymap.set('n', kmaps.Declaration, vim.lsp.buf.declaration, { buffer = true })
        vim.keymap.set('n', kmaps.Definition, vim.lsp.buf.definition, { buffer = true })
        vim.keymap.set('n', kmaps.Rename, vim.lsp.buf.rename, { buffer = true })
        vim.keymap.set('n', kmaps.Hover, vim.lsp.buf.hover, { buffer = true })
        vim.keymap.set('n', kmaps.Implementation, vim.lsp.buf.implementation, { buffer = true })
        -- vim.keymap.set('n', kmaps.Definition, vim.lsp.buf.type_definition, { buffer = true })
        vim.keymap.set('n', kmaps.References, vim.lsp.buf.references, { buffer = true })
        vim.keymap.set('n', kmaps.DocumentSymbol, vim.lsp.buf.document_symbol, { buffer = true })
        vim.keymap.set('n', kmaps.WorkspaceSymbol, vim.lsp.buf.workspace_symbol, { buffer = true })
        -- vim.keymap.set('n', kmaps.Declaration, vim.lsp.buf.signature_help)
        vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { buffer = true })
    end
})

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
-- vim.keymap.set('n', '<Leader>mm', function() require('mpd'):status() end)
-- vim.keymap.set('n', '<Leader>mp', function() require('mpd'):toggle() end)

-- Commands

-- vim.api.nvim_create_user_command('LTeX', function(args)
--     vim.lsp.enable()
-- end, {
--     complete = {
--         'start',
--         'stop',
--     }
-- })

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

vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('anri/TermOptions', { clear = true }),

    callback = function()
        local win = vim.api.nvim_get_current_win()
        vim.wo[win][0].spell = false
        vim.wo[win][0].colorcolumn = ''
    end
})

vim.api.nvim_create_user_command('Internet', function(o)
    local escaped = vim.uri_encode(o.args)
    vim.ui.open(('https://duckduckgo.com/?q=%s'):format(escaped))
end, { nargs = 1, desc = 'Search on the internet.' })

vim.api.nvim_create_user_command('SetExecutableFlag', function()
    local file = vim.fn.expand('%')

    Job.chain(
        Job:new({
            command = 'git',
            args = { 'add', '-f', file }
        }),

        Job:new({
            command = 'git',
            args = { 'update-index', '--chmod=+x', file },
        }),

        Job:new({
            command = 'chmod',
            args = { '+x', file }
        })
    )
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
