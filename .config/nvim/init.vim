" vim: filetype=vim

" ---------- "
" leader key "
" ---------- "
" set leader key
" let g:mapleader=','

" Remove any possible mapping beforehand
nnoremap <SPACE> <Nop>
" Set the leader to space
let g:mapleader = " "


" ----- "
" VIMRC "
" ----- "

source $HOME/.config/nvim/after/plugin/plugin-overview.vim

source $HOME/.config/nvim/after/general-settings.vim

source $HOME/.config/nvim/after/mappings.vim

source $HOME/.config/nvim/after/plugin/plugin-config.vim

source $HOME/.config/nvim/after/autocommands.vim

" -----------------------------------
"  Paths
" -----------------------------------
" let g:python3_host_prog = expand("~/.config/nvim/py3-provider/bin/python")
" Overwrite this for each venv!

" Visual stuff
source $HOME/.config/nvim/after/visual.vim
