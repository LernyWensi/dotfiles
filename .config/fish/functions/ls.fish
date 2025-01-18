function ls --wraps ls
    command ls \
        --almost-all \
        --color \
        --classify \
        --group-directories-first \
        $argv
end
