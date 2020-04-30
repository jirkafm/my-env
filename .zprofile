TMUX_ONSTARTUP=N

if command -v tmux &> /dev/null && [ -z "$TMUX" ] && [[ "$TMUX_ONSTARTUP" == 'Y' ]]; then
	    tmux attach -t default || tmux new -s default
fi
