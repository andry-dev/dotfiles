setlocal spell
"setlocal conceallevel=2

"inoreabbrev <buffer> list! \begin{itemize}<CR>\item<CR>\end{itemize}<Up>

lua <<EOF
require'cmp'.setup.buffer {
  sources = {
    { name = 'latex_symbols' },
  },
}
EOF
