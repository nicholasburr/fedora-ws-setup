# Automatically start a new tmux session for every shell
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    # Try to attach to a session named "main", or create it if it doesn't exist
    tmux attach-session -t main 2>/dev/null || tmux new-session -s main
fi
#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#    tmux new-session
#fi

if [ -z "$TMUX" ]; then
    cd $HOME/Desktop
fi

