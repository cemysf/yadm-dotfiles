#!/usr/bin/env bash

# When XXH-ing, auto-fill the known hosts

_xxh() {
  local cur prev words cword
  _init_completion || return
  _known_hosts_real -a "$cur"
} && complete -F _xxh xxh
