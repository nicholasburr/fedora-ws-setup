# --- History --- 
export HISTSIZE=25000
export HISTFILESIZE=25000
shopt -s histappend
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# --- hstr ---
export HSTR_CONFIG=raw-history-view # sort in chronological order
export HISTCONTROL=ignoreboth
alias hh=hstr                       # hh to be alias for hstr
export HSTR_CONFIG=hicolor          # get more colors
shopt -s histappend                 # append new history items to .bash_history
export HISTCONTROL=ignorespace      # leading space hides commands from history
export HISTFILESIZE=10000           # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}     # increase history size (default is 500)
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
function hstrnotiocsti {
    { READLINE_LINE="$( { </dev/tty hstr ${READLINE_LINE}; } 2>&1 1>&3 3>&- )"; } 3>&1;
    READLINE_POINT=${#READLINE_LINE}
}
if [[ $- =~ .*i.* ]]; then bind -x '"\C-r": "hstrnotiocsti"'; fi
export HSTR_TIOCSTI=n

