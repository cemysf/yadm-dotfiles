#!/usr/bin/env bash

# When SSH-ing, auto-fill the known hosts

_known_hosts() {
    local know_hosts cur
    known_hosts=$(cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\[")

    cur="${COMP_WORDS[COMP_CWORD]}"

    COMPREPLY=( $(compgen -W "$known_hosts" -- ${cur}) )
    return 0
}


complete -F _known_hosts wait-for-host;
complete -F _known_hosts ssh;

