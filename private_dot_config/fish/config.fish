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

# opencode
fish_add_path /home/andry/.opencode/bin
# >>> kache test runner >>>
if test -z "$CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUNNER"; set -gx CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUNNER 'kache test-runner'; else; set -gx CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUNNER $CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUNNER; end
# <<< kache test runner <<<
# >>> kache compiler cache >>>
if test "$PATH[1]" != '/home/andry/.local/lib/kache/shims'
    set -gx PATH '/home/andry/.local/lib/kache/shims' $PATH
end
# <<< kache compiler cache <<<

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
set -gx MAMBA_EXE "/home/andry/miniforge3/bin/mamba"
set -gx MAMBA_ROOT_PREFIX "/home/andry/.local/share/mamba"
$MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<
