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

# alias_if_valid: function that creates an alias if the replacement command is installed
# example usage: alias_if_valid lsd ls -A
# this will create an alias "ls" that runs "lsd -A" if lsd is installed
alias_if_valid() {
	replacement=$2
	original=$1
	restargs=${@:3}
	if command -v $replacement &> /dev/null; then
		alias -g $original="$replacement"
	else 
		# exit with error if the replacement command is not installed
		return 1
	fi
}

# run_w_reminder: function that runs specified command with arguments and prints a reminder at the end
# example usage: run_w_reminder "Notice: foobar" ls -A
# this will run "ls -A" and print "Notice: foobar" at the end
run_w_reminder() {
	reminder=$1
	shift
	$@
	echo >&2
	echo $reminder >&2
}

# alias_remind: function that creates an alias to run_w_reminder to remind the user to use a better alternative
# example usage: alias_remind ls lsd 
# this will create an alias "ls" that runs "ls" and prints a reminder to use lsd at the end
alias_remind() {
	replacement=$2
	original=$1
	if command -v $replacement &> /dev/null; then
		alias -g $original="run_w_reminder 'Notice: use $replacement instead' $original"
	else
		# exit with error if the replacement command is not installed
		return 1
	fi
}

# replace tools with better alternatives if they are installed
# these come with oh-my-zsh§
# alias lsa='ls -lah'
# alias l='ls -lah'
# alias ll='ls -lh'
# alias la='ls -lAh'

# replace tools with better alternatives if they are installed
# except if the syntax is different, just remind the user to use the better alternative
alias_if_valid ls lsd || alias ls="ls --color=tty"
alias_if_valid cat bat
alias_if_valid dnf dnf5
alias_if_valid top htop
alias_if_valid vim nvim
alias_if_valid less bat

alias_remind find fd
alias_remind grep rg || alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,venv}"
alias_remind du dust  || alias du="du -h"

alias ps="ps x"
alias dps="docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}'"
alias tssh='TERM=xterm-256color /usr/bin/env ssh -o RequestTTY=yes -o RemoteCommand="tmux new -As0 zsh"'
alias free="free -h"
alias df="df -h"
alias lsblk="lsblk -o NAME,SIZE,FSTYPE,LABEL,PARTLABEL,MOUNTPOINTS"
alias xssh='TERM=xterm-256color /usr/bin/env ssh' # fix kitty terminal

ssh() {
	kitten ssh -o RequestTTY=yes "$@" tmux new -As0 zsh
}
