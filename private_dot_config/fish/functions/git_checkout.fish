function git_checkout
    set -l branch $(git branch --all | fzf | sed "s/remotes\/origin\///" | xargs)
    if test -n "$branch"
        git checkout "$branch"
    end
end
