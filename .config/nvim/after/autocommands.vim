" vim: filetype=vim

" ----------------------------------------------------
" Autocommands
" ----------------------------------------------------
" File-specific configs are available in ~/.config/nvim/after/ftplugin/
" (e.g. ~/.config/nvim/after/ftplugin/python.vim)

" augroup GROPU
"     " Clears all of the autocommands defined IN THIS GROUP
"     autocmd!
"     autocmd BufCreate * echom "New buffer!"
" augroup end"




" ----------------------------------------------------
" VIM rc
" ----------------------------------------------------
" au! BufWritePost $MYVIMRC ++nested source % " auto source when writing to init.vm alternatively you can run :source $MYVIMRC
au! BufWritePost ~/.config/nvim/init.vim ++nested source % " auto source when writing to init.vm alternatively you can run :source $MYVIMRC
" ++nested required for bufferline
" " Stops highlighting after saving!
" https://github.com/itchyny/lightline.vim/issues/406

" ----------------------------------------------------
" Dockerfile
" -------------------------------- # vim:set ft=dockerfile:


" Vertially align all \ cmds
" :Tabularize /.*\zs\

" ----------------------------------------------------
" HTML
" -------------------------------- # vim:set ft=html:
" autocmd BufNewFile,BufRead *.html setlocal nowrap
" This will turn line wrapping off whenever you're working on an HTML file.
" autocmd BufWritePre,BufRead *.html :normal gg=G"
" " reindent the code whenever we read an HTML file as well as when we write it

" -----------------------------------
" YAML
" -------------------------------- # vim:set ft=yaml:

" necessary?
" autocmd BufWritePre,BufRead *.yaml :normal gg=G"


" -----------------------------------
" GIT
" -----------------------------------
autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete


" -----------------------------------
" JSON
" -------------------------------- # vim:set ft=json:

" TODO Move to the augroup?
" autocmd FileType json syntax match Comment +\/\/.\+$+
" Handled automatically by the 'prettier' CoC extension
" reindent the file whenever we read or write it
" autocmd BufWritePre,BufRead *.json :normal gg=G"


" necessary?
" :syntax on
augroup filetype_json


  " Comments in JSON files
  autocmd FileType json syntax match Comment +\/\/.\+$+

  " " Folding
  " autocmd FileType json :setlocal foldmethod=syntax

  " The first autocommand sets 'indent' as the fold method before a file is loaded, so that indent-based folds will be defined.
  " au BufReadPre * setlocal foldmethod=syntax
  " au BufRead * setlocal foldmethod=syntax
  " The second one allows you to manually create folds while editing. It's executed after the modeline is read, so it won't 
  " change the fold method if the modeline set the fold method to something else like 'marker' or 'syntax'.
  " au BufWinEnter * if &fdm == 'syntax' | setlocal foldmethod=manual | endif

augroup END


" -----------------------------------
" glTF
" -------------------------------- # vim: set ft=json
" (has a json structure)
autocmd BufNewFile,BufRead *.gltf set syntax=json

" -----------------------------------
" Python
" -------------------------------- # vim: set ft=python
" TODO
" SET THIS IN ~/.vim/after/ftplugin/python.vim
" https://vi.stackexchange.com/questions/18231/what-is-the-difference-of-using-au-bufnewfile-bufread-py-and-au-filetype-py
" autocmd BufNewFile,BufRead *.py set foldmethod=indent


""  ---- Minimal configuration:
"set smartindent   " Do smart autoindenting when starting a new line
"set shiftwidth=4  " Set number of spaces per auto indentation
"set expandtab     " When using <Tab>, put spaces instead of a <tab> character
"
"" ---- Good to have for consistency
"" set tabstop=4   " Number of spaces that a <Tab> in the file counts for
"" set smarttab    " At <Tab> at beginning line inserts spaces set in shiftwidth
"
"" ---- Bonus for proving the setting
"" Displays '-' for trailing space, '>-' for tabs and '_' for non breakable space
"set listchars=tab:>-,trail:-,nbsp:_
"set list
