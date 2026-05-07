# --- History --- 
export HISTSIZE=25000
export HISTFILESIZE=25000
shopt -s histappend
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# --- hstr ---
alias hh=hstr                     
shopt -s histappend               
export HSTR_CONFIG=raw-history-view 
export HISTCONTROL=ignoreboth
export HSTR_CONFIG=hicolor        
export HISTCONTROL=ignorespace    
export HISTFILESIZE=10000         
export HISTSIZE=${HISTFILESIZE}    
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
function hstrnotiocsti {
    { READLINE_LINE="$( { </dev/tty hstr ${READLINE_LINE}; } 2>&1 1>&3 3>&- )"; } 3>&1;
    READLINE_POINT=${#READLINE_LINE#}
}
if [[ $- =~ .*i.* ]]; then bind -x '"\C-r": "hstrnotiocsti"'; fi
export HSTR_TIOCSTI=n

