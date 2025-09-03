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
        listeners = {
            power = true,
        },

        sleep_delay = 1,

        multi_threaded = true,
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
            ---@type system_events.ACEvent.StatusChanged
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
                base_plugin_path .. 'focus',
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
        DocumentSymbol = '<leader>ls',
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
    vim.g.neovide_scroll_animation_length = 0

    vim.g.neovide_refresh_rate_idle = 5

    vim.o.guifont = "Pragmasevka Nerd Font:h14"
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
vim.o.smartindent = true
vim.o.foldmethod = 'indent'
vim.o.foldenable = false
vim.o.foldlevelstart = 99
vim.o.foldopen = 'hor,mark,percent,quickfix,search,tag,undo'
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
local function set_pretty_theme()
    require('config.themes').set_pretty_theme()
end

local function set_default_theme()
    require('config.themes').set_default_theme()
end


-- Mappings

---
---@param mode string|string[]
---@param key string
---@param func string|function
---@param opts? vim.keymap.set.Opts
local function map(mode, key, func, opts)
    ---@type vim.keymap.set.Opts
    opts = opts or {}
    opts = vim.tbl_extend('force', { noremap = true }, opts)

    vim.keymap.set(mode, key, func, opts)
end

-- Io senza questi tre mapping sotto non vivo

map('n', '<C-f>', function()
    require('fzf-lua').git_files()
end)

map('n', '<M-f>', function()
    require('fzf-lua').files()
end)

map('n', '<C-s>', function()
    require('fzf-lua').live_grep_native()
end)

map('n', '<C-b>', function()
    require('fzf-lua').buffers()
end)

map('n', '<C-p>', function()
    require('fzf-lua').files({
        fd_opts = '-t d --exact-depth 2',
        cwd = '~/prjs',
        actions = { enter = require('fzf-lua.actions').cd },
    })
end)

map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

map('i', '<C-u>', '<Nop>')

map({ 'n', 'v' }, ';', ':')
map('n', ':', ';')

map('n', 'j', 'gj')
map('n', 'k', 'gk')

map('n', '<Left>', ':cprev<CR>')
map('n', '<Right>', ':cnext<CR>')
map('n', '<Up>', '<Nop>')
map('n', '<Down>', '<Nop>')
map('n', 'h', '<Nop>')
map('n', 'l', '<Nop>')

map('n', 'cw', 'ciw')

map('n', '<CR>', function()
    vim.cmd [[nohlsearch]]
    return "<CR>"
end, { expr = true, silent = true })

map('n', '<Leader>se', ':SetExecutableFlag<CR>', { silent = true })
map('n', '<Leader>fm', function()
    local Job = require('plenary.job')
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
map('n', '<F2>', ':Make<CR>')
map('n', '<F3>', ':noautocmd vim /<FIND>/ **/* <Bar> cfdo %s//<REPLACE>/ce <Bar> wa')

map('t', '<Esc>', [[<C-\><C-n>]])

-- LSP

map('n', vim.g.anri.keymaps.Diagnostic, vim.diagnostic.open_float)

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local kmaps = vim.g.anri.keymaps

        map('n', '<leader>qa', vim.diagnostic.setqflist, { buffer = true })

        map({ 'v', 'n' }, kmaps.CodeAction, function()
            require('fzf-lua').lsp_code_actions()
        end, { buffer = true })

        map('n', kmaps.Declaration, vim.lsp.buf.declaration, { buffer = true })
        map('n', kmaps.Definition, vim.lsp.buf.definition, { buffer = true })
        map('n', kmaps.Rename, vim.lsp.buf.rename, { buffer = true })
        map('n', kmaps.Hover, vim.lsp.buf.hover, { buffer = true })
        map('n', kmaps.Implementation, vim.lsp.buf.implementation, { buffer = true })

        map('n', kmaps.References, function()
            require('fzf-lua').lsp_references()
        end, { buffer = true })

        map('n', kmaps.DocumentSymbol, function()
            require('fzf-lua').lsp_document_symbols()
        end, { buffer = true })

        map('n', kmaps.WorkspaceSymbol, function()
            require('fzf-lua').lsp_workspace_symbols()
        end, { buffer = true })

        map('i', '<C-s>', vim.lsp.buf.signature_help, { buffer = true })

        vim.api.nvim_create_user_command('InlayHintToggle', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = 'Toggle inlay hints' })
    end
})

map('n', '<leader>tt', function()
    require('neotest').run.run()
end, { silent = true })

map('n', '<leader>tf', function()
    require('neotest').run.run(vim.fn.expand('%'))
end, { silent = true })

map('n', '<leader>ts', function()
    require('neotest').summary.toggle()
end, { silent = true })

map('v', '<leader>hr', '<Plug>FocusHL_red')
map('v', '<leader>hg', '<Plug>FocusHL_green')
map('v', '<leader>hb', '<Plug>FocusHL_blue')
map('v', '<leader>hc', '<Plug>FocusHLClear')

vim.api.nvim_create_user_command('DefaultTheme', function()
    set_default_theme()
end, {})

vim.api.nvim_create_user_command('PrettyTheme', function()
    set_pretty_theme()
end, {})

vim.api.nvim_create_user_command('Projects', function()
    require('fzf-lua').zoxide()
end, {})

vim.api.nvim_create_user_command('EditPlugin', function()
    local plugin_path = '~/.local/share/chezmoi/private_dot_config/nvim'
    vim.cmd.lcd(plugin_path)
    require('fzf-lua').files({ cwd = plugin_path })
end, {})

vim.api.nvim_create_user_command('EditDotfiles', function()
    local plugin_path = '~/.local/share/chezmoi'
    require('fzf-lua').files({ cwd = plugin_path })
    vim.cmd.lcd(plugin_path)
end, {})

vim.api.nvim_create_user_command('EnableAutoformat', function()
    globals.enable_autoformat(true)
end, {})

vim.api.nvim_create_user_command('Format',
    ---@param args vim.api.keyset.create_user_command.command_args
    function(args)
        if args.fargs[1] == 'enable' and not args.bang then
            vim.b.disable_autoformat = false
        elseif args.fargs[1] == 'enable' and args.bang then
            vim.g.disable_autoformat = false
        elseif args.fargs[1] == 'disable' and not args.bang then
            vim.b.disable_autoformat = true
        elseif args.fargs[1] == 'disable' and args.bang then
            vim.g.disable_autoformat = true
        end
    end, {
        nargs = 1,
        bang = true,
        desc = 'Controls autoformat on save',

        ---@param arglead string
        ---@param cmdline string
        ---@param cursorpos number
        complete = function(arglead, cmdline, cursorpos)
            local n_params = vim.split(cmdline, ' ')

            if #n_params < 3 then
                return { "enable", "disable" }
            else
                return {}
            end
        end
    })

-- vim.api.nvim_create_user_command("FormatDisable", function(args)
--     if args.bang then
--         -- FormatDisable! will disable formatting just for this buffer
--         vim.b.disable_autoformat = true
--     else
--         vim.g.disable_autoformat = true
--     end
-- end, {
--     desc = "Disable autoformat-on-save",
--     bang = true,
-- })
--
-- vim.api.nvim_create_user_command("FormatEnable", function(args)
--     if args.bang then
--         vim.b.disable_autoformat = false
--     else
--         vim.g.disable_autoformat = false
--     end
-- end, {
--     desc = "Re-enable autoformat-on-save",
--     bang = true,
-- })

map('n', '<F4>', function()
    require('dap').continue()
end)

map('n', '<F5>', function()
    require('dap').step_over()
end)

map('n', '<F6>', function()
    require('dap').step_into()
end)

map('n', '<F7>', function()
    require('dap').step_out()
end)

map('n', '<Leader>db', function()
    require('dap').toggle_breakpoint()
end)

map('n', '<Leader>dB', function()
    require('dap').set_breakpoint(vim.fn.input('When? '))
end)

map('n', '<Leader>dr', function()
    require('dap').repl_open()
end)

vim.api.nvim_create_user_command('ToggleDebug', function()
    require('dapui').toggle()
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
    local Job = require('plenary.job')

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
