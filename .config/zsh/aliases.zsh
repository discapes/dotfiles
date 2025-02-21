
swap() {
	#[ "$#" -ne 2 ] || [ ! -f "$1" ] || [ ! -f "$2" ] && echo "invalid arguments" && return 1
	[ ! -f "$1" ] || [ ! -f "$2" ] && echo "invalid arguments" && return 1
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE "$2"
}

cm() {
	git add -A
	git commit -m "$*"
	git push
}

dive() {
	env dive <(docker save $1) --source=docker-archive
}

# example usage:
# _alias_if_valid ls "lsd -A"
# to replace ls with lsd -A if lsd is installed
alias_if_valid() {
	replacement=$2
	original=$1
	restargs=${@:3}
	if command -v $replacement &> /dev/null; then
		alias $original="$replacement $restargs"
	fi
}


# replace tools with better alternatives if they are installed
alias_if_valid ls lsd -A
alias_if_valid cat bat
alias_if_valid find fd
alias_if_valid du dust
alias_if_valid top htop
alias_if_valid dnf dnf5
alias_if_valid nvim distrobox enter arch -- nvim
alias ps="ps x"
alias vim="nvim"
compdef nvim="nvim"
compdef vim="nvim"

# add better args to some commands
alias free="free -h"
alias df="df -h"
alias lsblk="lsblk -o NAME,SIZE,FSTYPE,LABEL,PARTLABEL,MOUNTPOINTS"
alias ssh='TERM=xterm-256color /usr/bin/env ssh' # fix kitty terminal

# utility
alias tssh='TERM=xterm-256color /usr/bin/env ssh -o RequestTTY=yes -o RemoteCommand="tmux new -As0"'

