function fish_prompt
    echo -n (set_color purple)(basename (prompt_pwd))
    echo -n (set_color white)(fish_git_prompt)
    echo -n ' '
    echo -n (set_color green)'❯'(set_color yellow)'❯'(set_color blue)'❯ '
    set_color normal
end
