# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Normally, '**' = '*', but now '**' will act as a recursive '*' through all directory levels
shopt -s globstar

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# HISTCONTROL=ignoreboth
export HISTCONTROL=erasedups	# when adding an item to history, delete itentical commands upstream

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# HISTSIZE=1000
export HISTSIZE=10000		# save 10000 items in history
# HISTFILESIZE=2000
export HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# TODO Get inspiration from
#  https://github.com/nelstrom/dotfiles/blob/master/bashrc
# # Bash customisations to be syncronised between machines.
# export PS1='\[\e[1;34m\][\u@\h \W]\$\[\e[0m\] '

# Don't print massive paths in the prompt...
# PROMPT_DIRTRIM=1
# PROMPT_DIRTRIM=2
PROMPT_DIRTRIM=3

if [ "$color_prompt" = yes ]; then
    # default PS1
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # fancier
    # main colors
    # 30 -> black
    # 31 -> red
    # 32 -> green
    # 36 -> cyan
    # 36 -> cyan
    # 95 -> light magenta
    # background colors
    # 47 -> light gray
    # 49 -> defaut
    PS1="\[\e[95m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[95m\]]\[\e[m\]\[\e[31;49m\]\\$\[\e[m\] "
else
    # "color_prompt" was not yes! Maybe it's an known $TERM. force it with "force_color_prompt"
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# export PS1="\[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32;47m\]\\$\[\e[m\] "

# If running within Ranger, modify the PS1
if [ -n "$RANGER_LEVEL" ]; then export PS1="[ranger]$PS1"; fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# ALIAS DEFINITIONS
# --------------------------------------------------------------------------------
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# FUNCTION DEFINITIONS
# --------------------------------------------------------------------------------
if [ -f ~/.bash_functions ]; then
    source ~/.bash_functions
fi

# AUTOCOMPLETION
# --------------------------------------------------------------------------------

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# # The autocompletion *.bash files are at ~/.local/share/bash-completion/completions/

# # My LOCAL autocompletion files in ~/.bash_completion.d
# # # mkdir -p ~/.bash_completion.d
# # for bcfile in ~/.bash_completion.d/* ; do
# #   [ -f "$bcfile" ] && . $bcfile
# # done

# if [[ -d ~/.bash_completion.d/ ]] && \
#    ! find ~/.bash_completion.d/. ! -name . -prune -exec false {} +
# then
#     for f in ~/.bash_completion.d/*
#     do
#         source "$f"
#     done
# fi

# AUTOCOMPLETION FOR ALIASES
# --------------------------------------------------------------------------------
# HAS TO GO AFTER BOTH ALIASES AND AUTOCOMPLETE!
# https://superuser.com/questions/436314/how-can-i-get-bash-to-perform-tab-completion-for-my-aliases

# Automatically add completion for all aliases to commands having completion functions
function alias_completion {
    local namespace="alias_completion"

    # parse function based completion definitions, where capture group 2 => function and 3 => trigger
    local compl_regex='complete( +[^ ]+)* -F ([^ ]+) ("[^"]+"|[^ ]+)'
    # parse alias definitions, where capture group 1 => trigger, 2 => command, 3 => command arguments
    local alias_regex="alias ([^=]+)='(\"[^\"]+\"|[^ ]+)(( +[^ ]+)*)'"

    # create array of function completion triggers, keeping multi-word triggers together
    eval "local completions=($(complete -p | sed -Ene "/$compl_regex/s//'\3'/p"))"
    (( ${#completions[@]} == 0 )) && return 0

    # create temporary file for wrapper functions and completions ("rm" prevents it from being aliased to trash-put)
    "rm" -f "/tmp/${namespace}-*.tmp" # preliminary cleanup
    local tmp_file; tmp_file="$(mktemp "/tmp/${namespace}-${RANDOM}XXX.tmp")" || return 1

    local completion_loader; completion_loader="$(complete -p -D 2>/dev/null | sed -Ene 's/.* -F ([^ ]*).*/\1/p')"

    # read in "<alias> '<aliased command>' '<command args>'" lines from defined aliases
    local line; while read line; do
        eval "local alias_tokens; alias_tokens=($line)" 2>/dev/null || continue # some alias arg patterns cause an eval parse error
        local alias_name="${alias_tokens[0]}" alias_cmd="${alias_tokens[1]}" alias_args="${alias_tokens[2]# }"

        # skip aliases to pipes, boolean control structures and other command lists
        # (leveraging that eval errs out if $alias_args contains unquoted shell metacharacters)
        eval "local alias_arg_words; alias_arg_words=($alias_args)" 2>/dev/null || continue
        # avoid expanding wildcards
        read -a alias_arg_words <<< "$alias_args"

        # skip alias if there is no completion function triggered by the aliased command
        if [[ ! " ${completions[*]} " =~ " $alias_cmd " ]]; then
            if [[ -n "$completion_loader" ]]; then
                # force loading of completions for the aliased command
                eval "$completion_loader $alias_cmd"
                # 124 means completion loader was successful
                [[ $? -eq 124 ]] || continue
                completions+=($alias_cmd)
            else
                continue
            fi
        fi
        local new_completion="$(complete -p "$alias_cmd")"

        # create a wrapper inserting the alias arguments if any
        if [[ -n $alias_args ]]; then
            local compl_func="${new_completion/#* -F /}"; compl_func="${compl_func%% *}"
            # avoid recursive call loops by ignoring our own functions
            if [[ "${compl_func#_$namespace::}" == $compl_func ]]; then
                local compl_wrapper="_${namespace}::${alias_name}"
                    echo "function $compl_wrapper {
                        (( COMP_CWORD += ${#alias_arg_words[@]} ))
                        COMP_WORDS=($alias_cmd $alias_args \${COMP_WORDS[@]:1})
                        (( COMP_POINT -= \${#COMP_LINE} ))
                        COMP_LINE=\${COMP_LINE/$alias_name/$alias_cmd $alias_args}
                        (( COMP_POINT += \${#COMP_LINE} ))
                        $compl_func
                    }" >> "$tmp_file"
                    new_completion="${new_completion/ -F $compl_func / -F $compl_wrapper }"
            fi
        fi

        # replace completion trigger by alias
        new_completion="${new_completion% *} $alias_name"
        echo "$new_completion" >> "$tmp_file"
    done < <(alias -p | sed -Ene "s/$alias_regex/\1 '\2' '\3'/p")
    source "$tmp_file" && rm -f "$tmp_file"
}; alias_completion

# CONFIGURE EDITOR
# --------------------------------------------------------------------------------


# Swaps caps-lock and ESC keys
setxkbmap -option caps:swapescape

# NEOVIM REMOTE /usr/local/bin/nvr (detect terminals within neovim) 

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  # INSIDE OF NEOVIM!
  # export PS1="[nvr]$"

  # default PS1
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  export PS1="[nvr]${PS1}"

  # Don't print massive paths in the NVR prompt...
  PROMPT_DIRTRIM=1
  # PROMPT_DIRTRIM=2
  # PROMPT_DIRTRIM=3

  # Add a newline for readability
  export PS1="${PS1}\n> "


  # VISUAL can also be set by ~/.config/nvim/init.vim!  (dotfiles/nvim/after/general-settings.vim)
  # but this way the VISUAL & EDITOR env vars are updated
  export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'";

  # INCORRECT!
  # export $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'";

  alias v="nvr"
  alias vi="nvr"
  alias vim="nvr"
  alias nvim="nvr"
  alias neovim="nvr"
else
  export VISUAL="nvim"

  alias v="${VISUAL}"
  alias vi="${VISUAL}"
  alias vim="${VISUAL}"
  alias neovim="${VISUAL}"
fi

# Propagate the results
export EDITOR="${VISUAL}"

# Emacs vs vim mode
# Emacs so that <C-x><C-e> activates vim editing-mode within nvr
set -o emacs
# set -o vi

# "\C-o": operate-and-get-next
# With this, once you have selected a command from history (e.g. via Vim search) 
# hit Ctrl-O instead of Enter and Bash will run the command and insert the next 
# command from history, ready to run.  See Readline Command Names section in the Bash manpage for 
# complete list.

bind -x '"\C-l": clear'

# neofetch

# for debugging nautilus...
# G_DEBUG="all" NAUTILUS_DEBUG="All" nautilus

# For some programs?
# export LC_CTYPE="en_US.utf8"


# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ignacio/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ignacio/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ignacio/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ignacio/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

