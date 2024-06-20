swap() {
	#[ "$#" -ne 2 ] || [ ! -f "$1" ] || [ ! -f "$2" ] && echo "invalid arguments" && return 1
	[ ! -f "$1" ] || [ ! -f "$2" ] && echo "invalid arguments" && return 1
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE "$2"
}

alias ls="lsd -A"
alias ssh_readonly="TERM=xterm-256color /usr/bin/env ssh"
alias ssh="kitty +kitten ssh"
alias dnf="sudo dnf5"
alias vim="nvim"
#alias rm="echo 'Use trash!' && false"

