if status is-interactive
    alias ls='ls --color=never'
    alias ll='ls -lah --color=never'
    alias rsync='rsync --progress -r'
    alias gs='git status'
    alias gcm='git commit'
    alias gco='git_checkout'
    alias grb='git rebase'
    alias gre='git remote'
    alias gpl='git pull'
    alias gps='git push'
    alias mkdir='mkdir -p'
    alias pstop='podman_stop'
    alias j='journalctl -efu'
    alias ju='journalctl --user -efu'
    alias sctlu='systemctl --user'
    alias sctl='systemctl'

    alias sduo='sudo'
    alias suod='sudo'
    alias usdo='sudo'
    alias fisp='sudo'
    alias aysi='sudo'
    alias aaaa='sudo'
    alias fuck='sudo'
    alias shit='sudo'

    bind ctrl-f open_file_manager

    zoxide init fish | source
    direnv hook fish | source
    mise activate fish | source
end

set -g fish_history ""
set -g EDITOR nvim
