"packadd! termdebug

"nnoremap <buffer> <Leader>ls call LanguageClient#findLocations({'method':'$ccls/call'})<CR>

inoreabbrev <buffer> arr! std::array<
inoreabbrev <buffer> vec! std::vector<
