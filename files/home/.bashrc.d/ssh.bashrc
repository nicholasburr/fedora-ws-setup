setup_ssh_agent() {
    # 1. Skip non-interactive shells to prevent blocking background jobs/scripts
    [[ $- != *i* ]] && return 0

    # 2. Start a new agent only if none is running (respects GNOME Keyring, macOS launchd, etc.)
    if [[ -z "$SSH_AUTH_SOCK" ]]; then
        command -v ssh-agent &>/dev/null && eval "$(ssh-agent -s)"
    fi

    # 3. Add SSH keys silently. Fails gracefully if no keys or agent is unreachable.
    if [[ -n "$SSH_AUTH_SOCK" ]] && command -v ssh-add &>/dev/null; then
        ssh-add 2>/dev/null
    fi
}

# Execute the function
setup_ssh_agent

