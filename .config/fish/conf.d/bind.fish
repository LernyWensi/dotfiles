bind --user \cf 'fg 2>/dev/null; commandline -f repaint'

bind --user \cz undo
bind --user \cy redo

bind --user \e\[1\;5D prevd-or-backward-word
bind --user \e\[1\;5C nextd-or-forward-word
