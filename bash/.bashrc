export PS1="\[\e[01;32m\]\u @ \h : \W [ \A ] >>> \[\e[38;5;15m\]"
alias ls='ls -hlaF --color=tty --group-directories-first'
alias cls='clear ; clear'
alias csl='clear ; clear'
alias emacs='emacs -nw'
alias emcas='emacs -nw'
alias emasc='emacs -nw'
cdl() {
    if [ -z "$1" ]
    then
        echo "NO DIR SPECIFIED ;" ; pwd ; ls
    else
        cd $1 ; pwd ; ls
    fi
}
cdb() {
    if [ -z "$1" ]
    then
        cd .. ;
    else
        for f in $(seq 1 $1) ;
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
        mkdir $1 ; cd $1 ; pwd
    fi
}