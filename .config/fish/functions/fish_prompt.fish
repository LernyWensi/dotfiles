function fish_prompt
    echo -n (set_color normal)(basename (prompt_pwd))
    echo -n (set_color green)(fish_git_prompt)
    echo -n ' '
    echo -n (set_color yellow)'λ '
    set_color normal
end
