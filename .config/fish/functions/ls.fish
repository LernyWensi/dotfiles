function ls --wraps eza
    eza \
        --tree \
        --level 1 \
        --all \
        --group-directories-first \
        --classify always \
        --no-user \
        --git \
        --git-repos \
        --time-style long-iso \
        $argv
end
