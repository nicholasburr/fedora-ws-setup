chromium-search() {
    local query="$*"
    chromium-browser "https://www.google.com/search?q=${query}" &>/dev/null &
}

if [ -z "$TMUX" ]; then
    cd $HOME/Desktop
fi
