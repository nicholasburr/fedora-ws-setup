setup_ssh_agent() {
    # 1. Skip non-interactive shells to prevent blocking background jobs/scripts
    [[ $- != *i* ]] && return 0

    local env_file="${HOME}/.ssh/agent_env"

    # Helper function to start a new agent, save its variables, and add keys
    start_agent() {
        # Start agent and suppress the "Agent pid..." output
        eval "$(ssh-agent -s)" >/dev/null
        
        # Save the agent connection details to a file for other sessions to use
        echo "export SSH_AUTH_SOCK=\"$SSH_AUTH_SOCK\"" > "$env_file"
        echo "export SSH_AGENT_PID=\"$SSH_AGENT_PID\"" >> "$env_file"
        chmod 600 "$env_file"
        
        # Add the keys
        ssh-add 2>/dev/null
    }

    # 2. If a previous session saved the agent environment, load it
    if [[ -f "$env_file" ]]; then
        source "$env_file" >/dev/null
    fi

    # 3. Check the actual status of the ssh-agent
    # ssh-add -l returns different exit codes based on the agent's state:
    #   0: Agent is running and has keys loaded
    #   1: Agent is running but has NO keys loaded
    #   2: Agent cannot be contacted (dead or not running)
    ssh-add -l &>/dev/null
    local status=$?

    if [[ $status -eq 2 ]]; then
        # Agent is unreachable. Start a new one.
        start_agent
    elif [[ $status -eq 1 ]]; then
        # Agent is running but missing keys. Add them.
        ssh-add 2>/dev/null
    fi
    # If status is 0, the agent is already running with keys. Do nothing!
}

# Execute the function
setup_ssh_agent
