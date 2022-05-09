let g:mapleader = ','

lua << EOF
    require 'plugins'
    require 'config/lsp'
    -- require 'plugins/dap'
    -- require 'plugins/compe'
    -- require 'plugins/treesitter'
    -- require 'plugins/iron'
    -- require 'plugins/diagnostics'
    -- require 'plugins/snippets'
    -- require 'plugins/comment'
    -- require 'plugins/snap'

    require('focus').setup()

    require 'config'
EOF

set wildmenu

set hlsearch
set ignorecase
set smartcase
set incsearch
set inccommand=nosplit
set gdefault
set undofile
set hidden
set spelllang=en,it,cjk
set nospell
set mouse=a
set listchars=tab:>\ ,nbsp:!,trail:.
set list
set colorcolumn=80,120
set foldlevelstart=99
set cpoptions+=J
set formatoptions+=p
set completeopt=menu,menuone,noselect
set ts=4 sts=4 sw=4 expandtab

set updatetime=1000

set dictionary+=/usr/share/hunspell/it_IT.dic
set dictionary+=/usr/share/hunspell/en_GB.dic

set omnifunc=v:lua.vim.lsp.omnifunc


" Mappings




" Vimwiki
let g:vimwiki_list = [{'path': '~/.local/share/vimwiki',
                    \}]

" Netrw
let g:netrw_liststype = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 1

" Deoplete
"call deoplete#custom#option('sources', {
"        \ '_': ['file', 'lsp'],
"        \ 'sql': ['vim-dadbod-completion']
"        \})


" CMake
let g:cmake_link_compile_commands = 1
let g:cmake_generate_options = ['-G Ninja']

" Tex
let g:tex_flavor="latex"

let g:vimtex_view_method = 'zathura'

" fn
function! FocusHLCompl()
    return luaeval("vim.tbl_keys(require('focus').config.colors)")
endfunction()

function! FocusHL()
    return luaeval("vim.tbl_keys(require('focus').config.colors)")
endfunction()

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Commands
command! ExecUnderLine :execute getline(".")
command! ExecSelection :execute getreg("*")
command! OpenPlugFolder :Dispatch! dolphin ~/.config/nvim/pack/andry/start
command! EditPlugin :FZF ~/.config/nvim/pack/andry/start

command! -range -nargs=1 -complete=customlist,andry#focus_hl_complete FocusHL  :call andry#focus_hl(<f-args>)


command! SetExecutableFlag :call andry#set_executable_flag()

command! SetupForScreens :call andry#setup_for_screenshots()

command! P :call fzf#run({'source': 'list-prjs', 'sink': 'cd'})

command! W :w suda://%
command! E :e suda://%

command! DefaultTheme :call andry#set_default_theme()
command! PrettyTheme :call andry#set_pretty_theme()

command! EnableAutoformat :lua require('globals').enable_autoformat(true)
command! DisableAutoformat :lua require('globals').enable_autoformat(false)

command! AsyncVimwiki2HTML :lua require('plugins/vimwiki-utils').compile()

" command! AsyncW2HTML :lua require('plugins/vimwiki-utils').compile_async()

" Auto commands

"au UIEnter * lua require('startup_screen').startup()

" Fix elixir's filetypes
au BufRead,BufNewFile *.ex,*.exs setlocal filetype=elixir

" Fix LaTeX filetypes
au BufRead,BufNewFile *.cls setlocal filetype=tex

" Async Vimwiki compilation
" au BufWritePost *.wiki :AsyncVimwiki2HTML

" Diagnostics
" au CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Tests
"augroup test
"  autocmd!
"  autocmd BufWrite * if test#exists() |
"    \   TestFile |
"    \ endif
"augroup END

" Java JDT
augroup lsp
    autocmd!
    autocmd FileType java
        \ autocmd! lsp BufWritePre <buffer> lua require('jdtls').organize_imports()
augroup END
