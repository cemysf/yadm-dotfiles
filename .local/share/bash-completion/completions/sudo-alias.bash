#!/usr/bin/env bash

# Let root user use your aliases

_comp_sudo_alias() { from="$2"; COMPREPLY=()
  if [[ $COMP_CWORD == 1 ]]; then
    COMPREPLY=( "$( alias -p | grep "^ *alias $from=" | sed -r "s/^ *alias [^=]+='(.*)'$/\1/" )" )
    return 0
  fi
  return 1
}
complete -o bashdefault -o default -F _comp_sudo_alias sudo
