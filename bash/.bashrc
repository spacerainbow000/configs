# terminal prompt color and formatting
export PS1="\[\e[01;32m\]\u @ \h : \W [ \A ] >>> \[\e[38;5;15m\]"

# infinite bash history
export HISTFILESIZE=
export HISTSIZE=

# shared history
shopt -s histappend
export HISTCONTROL=ignoredups
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}" #shared bash history

# emacs
export EDITOR=emacs
alias emacs='emacs -nw'
alias emcas='emacs -nw'
alias emasc='emacs -nw'

# screen clearing - cygwin-compatible
alias cls='clear ; clear'
alias csl='clear ; clear'

# prettier/more functional ls
alias ls='ls -hlaF --color=tty --group-directories-first'

# directory movement shortcut functions
cdl() {
    if [ -z "$1" ]
    then
	echo "NO DIR SPECIFIED ;" ; pwd ; ls
    else
	cd "${@}" && { pwd ; ls ; }
    fi
}
cdb() {
    if [ -z "$1" ]
    then
	cd .. ;
    else
	for f in $(seq 1 ${1}) ;
	do
	    cd .. ;
	done

    fi
    pwd ; ls
}
mkcd() {
    if [ -z "$1" ]
    then
	echo "NO DIR SPECIFIED ;" ; pwd
    else
	mkdir "${@}" && { cd "${@}" ; pwd ; }
    fi
}
