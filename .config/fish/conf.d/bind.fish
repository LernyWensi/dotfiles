bind --user ctrl-f 'fg 2>/dev/null; commandline -f repaint'

bind --user backspace backward-delete-char
bind --user ctrl-h backward-kill-word
bind --user delete delete-char
bind --user ctrl-delete kill-word

bind --user ctrl-z undo
bind --user ctrl-y redo

bind --user ctrl-left prevd-or-backward-word
bind --user ctrl-right nextd-or-forward-word
