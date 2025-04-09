if command -v bat &>/dev/null; then
	export MANPAGER="sh -c 'col -bx | bat -l man -p'"
	export MANROFFOPT="-c" # needed atleast on mac
else
	export MANPAGER="less -R --use-color -Dd+r -Du+b"
fi

command -v nvim &>/dev/null && export EDITOR=nvim || export EDITOR=vim

HISTFILE=~/.cache/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt notify
setopt complete_aliases
unsetopt autocd beep extendedglob nomatch
bindkey -v

pa() {
	export PATH="$PATH:$1"
}
pa ~/.local/bin
pa /usr/local/bin # for some reason this isn't default on mac (on some programs) - https://github.com/kovidgoyal/kitty/issues/1721
