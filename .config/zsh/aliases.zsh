swap() {
	#[ "$#" -ne 2 ] || [ ! -f "$1" ] || [ ! -f "$2" ] && echo "invalid arguments" && return 1
	[ ! -f "$1" ] || [ ! -f "$2" ] && echo "invalid arguments" && return 1
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE "$2"
}

setopt complete_aliases
alias ls="lsd -A"
alias ssh="TERM=xterm-256color /usr/bin/env ssh"
#alias ssh="kitty +kitten ssh"
alias dnf="sudo dnf5"
alias nvim="distrobox enter arch -- nvim"
alias vim="distrobox enter arch -- nvim"

cm() {
	git add -A
	git commit -m "$*"
}

compdef nvim="nvim"
compdef vim="nvim"
#alias rm="echo 'Use trash!' && false"

