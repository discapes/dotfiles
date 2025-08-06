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
# example usage: alias_if_valid ls lsd -A
# this will create an alias "ls" that runs "ls -A" if lsd is installed
alias_if_valid() {
	replacement=$2
	original=$1

	restargs=${@:3}
	if command -v $replacement &>/dev/null; then
		alias $original="$replacement $restargs"
	else
		# exit with error if the replacement command is not installed
		return 1
	fi
}

# run_w_reminder: function that runs specified command with arguments and prints a reminder at the end example usage: run_w_reminder "Notice: foobar" ls -A
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
	if command -v $replacement &>/dev/null; then
		alias $original="run_w_reminder 'Notice: use $replacement instead' $original"
	else
		# exit with error if the replacement command is not installed
		#
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
alias_if_valid vim myvim
alias_if_valid nvim myvim
alias_if_valid less bat
alias_if_valid c chezmoi
alias_if_valid vim nvim
#alias_if_valid cea chezmoi edit --watch --apply
# we don't need watch or apply since nvim is configured to apply saved files
#alias_if_valid cea chezmoi edit -- we should use nvims Projects instead so it restores session
alias ccd='cd "$(chezmoi source-path)"'
alias_if_valid lg lazygit

# alias_remind find fd
# alias_remind grep rg || alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,venv}"
# alias_remind du dust || alias du="du -h"
#

# check if user is in docker group
if groups | grep -q '\bdocker\b'; then
  alias d='docker'
else
  alias d='sudo docker'
fi
alias dps="d ps --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}'"
alias dn='d network inspect $(d network ls | awk '\''$3 == "bridge" { print $1 }'\'') | jq -r '\''.[] | .Name + " " + .IPAM.Config[0].Subnet'\'''
alias dip='d inspect -f $'\''{{.State.Status}}\t\t{{range .NetworkSettings.Networks}} {{.IPAddress}}{{end}}\t{{.Name}}'\'' $(d ps -aq) | column -t -s $'\''\t'\'''
alias dcu="d network create user --opt com.docker.network.bridge.gateway_mode_ipv4=nat-unprotected"
alias dr="d run -it --rm -d --network user --name"

alias ps="ps x"
#alias s='TERM=xterm-256color /usr/bin/env ssh -o RequestTTY=yes -o RemoteCommand="tmux new -As0 zsh"'
alias free="free -h"
alias df="df -h"
alias lsblk="lsblk -o NAME,SIZE,FSTYPE,LABEL,PARTLABEL,MOUNTPOINTS"
alias gc='git clone --depth=1'
alias gs="git status -s"
alias e="exit"
alias gd="git diff --color-words"
alias mitmproxy="mitmproxy 2>/dev/null" # bug on macOS
alias ca="chezmoi apply"
alias nr="nix --extra-experimental-features 'nix-command flakes' run"
if [ "$(uname -s)" = "Darwin" ]; then
  alias ns="sudo darwin-rebuild switch --flake ~/.local/share/chezmoi/nix-darwin"
  alias nsb="sudo darwin-rebuild boot --flake ~/.local/share/chezmoi/nix-darwin"
else
  alias ns="sudo nixos-rebuild switch --flake ~/.local/share/chezmoi/nixos"
  alias nsb="sudo nixos-rebuild boot --flake ~/.local/share/chezmoi/nixos"
fi
alias ff="fastfetch"

if [ "$TERM" == "xterm-kitty" ]; then
  # to connect to places where the kitten doesn't work eg. openwrt
  # then we also need to set TERM to avoid vim and tmux not working
	alias ssh_petfree='TERM=xterm-256color \ssh'
	alias ssh='kitten ssh'
	_s() {
    ssh -o RequestTTY=yes "$@" 'command -v tmux && (command -v zsh && SHELL=$(command -v zsh) tmux new -As0 zsh || tmux new -As0 bash) || bash'
	}
	alias s='_s'
else
	_s() {
		ssh -o RequestTTY=yes "$@" tmux new -As0 zsh
	}
	alias s='_s'
fi

