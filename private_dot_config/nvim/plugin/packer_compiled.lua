-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/andry/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/andry/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/andry/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/andry/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/andry/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["async.vim"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/async.vim"
  },
  dadbod = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/dadbod"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/editorconfig-vim"
  },
  fzf = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  gruvbox = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  ["gv.vim"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/gv.vim"
  },
  ["iron.nvim"] = {
    commands = { "IronRepl", "IronReplHere" },
    loaded = false,
    needs_bufread = false,
    path = "/home/andry/.local/share/nvim/site/pack/packer/opt/iron.nvim"
  },
  kommentary = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["nlua.nvim"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/nlua.nvim"
  },
  nofrils = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/nofrils"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text"
  },
  ["nvim-jdtls"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/andry/.local/share/nvim/site/pack/packer/opt/nvim-jdtls"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/andry/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["snippets.nvim"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/snippets.nvim"
  },
  ["symbols-outline.nvim"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/symbols-outline.nvim"
  },
  taskwiki = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/taskwiki"
  },
  ["vim-cmake"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/vim-cmake"
  },
  ["vim-dadbod-completion"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/vim-dadbod-completion"
  },
  ["vim-dispatch"] = {
    commands = { "Dispatch", "Make", "Focus", "Start" },
    loaded = false,
    needs_bufread = false,
    path = "/home/andry/.local/share/nvim/site/pack/packer/opt/vim-dispatch"
  },
  ["vim-elixir"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/opt/vim-elixir"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-moonfly-colors"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/vim-moonfly-colors"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/vim-test"
  },
  ["vim-testify"] = {
    commands = { "TestifyFile" },
    loaded = false,
    needs_bufread = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/opt/vim-testify"
  },
  vimpeccable = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/vimpeccable"
  },
  vimspector = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/vimspector"
  },
  vimwiki = {
    loaded = true,
    path = "/home/andry/.local/share/nvim/site/pack/packer/start/vimwiki"
  }
}

time([[Defining packer_plugins]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
vim.cmd [[command! -nargs=* -range -bang -complete=file Make lua require("packer.load")({'vim-dispatch'}, { cmd = "Make", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file TestifyFile lua require("packer.load")({'vim-testify'}, { cmd = "TestifyFile", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file IronReplHere lua require("packer.load")({'iron.nvim'}, { cmd = "IronReplHere", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file IronRepl lua require("packer.load")({'iron.nvim'}, { cmd = "IronRepl", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Start lua require("packer.load")({'vim-dispatch'}, { cmd = "Start", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Dispatch lua require("packer.load")({'vim-dispatch'}, { cmd = "Dispatch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Focus lua require("packer.load")({'vim-dispatch'}, { cmd = "Focus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType elixir ++once lua require("packer.load")({'vim-elixir'}, { ft = "elixir" }, _G.packer_plugins)]]
vim.cmd [[au FileType java ++once lua require("packer.load")({'nvim-jdtls'}, { ft = "java" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'vim-testify'}, { ft = "vim" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/andry/.local/share/nvim/site/pack/packer/opt/vim-elixir/ftdetect/elixir.vim]], true)
vim.cmd [[source /home/andry/.local/share/nvim/site/pack/packer/opt/vim-elixir/ftdetect/elixir.vim]]
time([[Sourcing ftdetect script at: /home/andry/.local/share/nvim/site/pack/packer/opt/vim-elixir/ftdetect/elixir.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
