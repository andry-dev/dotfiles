

command -nargs=? -complete=customlist,mpd#complete MPD  :call mpd#main(<f-args>)
