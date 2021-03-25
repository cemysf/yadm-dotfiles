" -----------------------------------
" Visual stuff
" -----------------------------------

" ---------
" nvim-colorizer.lua
" ---------
" " NOT WORKING
" lua require'colorizer'.setup()

" rainbow parentheses
" commands
" " Activate
" :RainbowParentheses
" " Deactivate
" :RainbowParentheses!
" " Toggle
" :RainbowParentheses!!
" " See the enabled colors
" :RainbowParenthesesColors

" Activation based on file type
augroup rainbow_lisp
  autocmd!
  autocmd FileType json,cpp,python,lisp,clojure,scheme RainbowParentheses
augroup END

" Use nicer symbols for tabstops and EOLs
 set listchars=tab:\ ,eol:⏎

" -----------------------------------
" Theme config
" -----------------------------------
packadd! onedark.vim

set cmdheight=2                         " More space for displaying messages

set pumheight=10                        " Makes popup menu smaller

set background=dark                     " tell vim what the background color looks like

set number                              " Line numbers

set cursorline                          " Enable highlighting of the current line
set ruler              			            " Show the cursor position all the time

" syntax on
syntax enable
" The ':syntax enable' command will keep your current color settings.  This
" allows using ':highlight' commands to set your preferred colors before or
" after using this command.  If you want Vim to overrule your settings with the
" defaults, use: >
"     :syntax on

" more minimalist...
" set noshowmode                          " We don't need to see things like -- INSERT -- anymore

colorscheme onedark

" -----------------------------------
" Lightline config
" -----------------------------------

" For lightline use https://github.com/itchyny/lightline.vim
packadd! lightline.vim
packadd! lightline-bufferline


" icons in lightline?
let g:lightline#bufferline#enable_devicons = 1

" Vertical splits hiding status bar...

"
let g:lightline = {
          \ 'enable': {
            \ 'statusline': 1,
            \ 'tabline': 1
            \ },
          \ 'component_function': {
          \   'fileformat': 'LightlineFileformat',
          \ },
         \ }

function! LightlineFileformat()
  return &filetype ==# 'netrw' ? '' : &fileformat
endfunction

" lightline-bufferline
" More at https://github.com/mengelbrecht/lightline-bufferline
"

" Stops highlighting after saving!
" https://github.com/itchyny/lightline.vim/issues/406

set showtabline=2 " Very important actually...
let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[No Name]'

let g:lightline                  = {}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
let g:lightline.colorscheme = "one"
