" vim: filetype=vim

" -------------------- "
" leader key shortcuts "
" -------------------- "

"" Close buffer
" noremap <Leader>c :bd<CR>
nnoremap <Leader>d :bp\|bd #<CR>
nnoremap <Leader>D :bp\|bd! #<CR>
noremap <Leader>q :q<CR>
noremap <Leader>Q :q!<CR>


"" Set working directory
" nnoremap <Leader>. :lcd %:p:h<CR>
"" Set working directory (and print the result)
nnoremap <Leader>. :lcd %:p:h<CR>:pwd<CR>

" terminal emulation
nnoremap <silent> <Leader>sh :terminal<CR>
" nnoremap <silent> <Leader>! :terminal<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" See the runtimepath
nnoremap  <Leader>rt :echo join(split(&runtimepath, ','),"\n") <CR>



" Save as root!
command! -nargs=0 Sw w !sudo tee % > /dev/null
command! -nargs=0 W w !sudo tee % > /dev/null
" command! -nargs=0 w\!\! w !sudo tee % > /dev/null

" Expand %% to the directory of the current file
cabbr <expr> %% expand('%:p:h')

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"


" Don't JUST use selection when indenting
vnoremap > >gv
vnoremap < <gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


" ----------- "
" new buffer! "
" ------------ "

nmap <silent> <Leader>ee :enew<CR>
" ------ "
" splits "
" ------ "
" split MIRRORING current buffer...
" nmap <silent> vv :vsplit<CR>
" nmap <silent> ss :split<CR>

" nmap <silent> vv :vnew<CR>
" nmap <silent> ss :new<CR>

" split  AND make a new buffer
nmap <silent> <Leader>vv :vnew<CR>
nmap <silent> <Leader>ss :new<CR>

" Open file in a split (like 'gf' but in a vertical split)
map <C-w>f <C-w>vgf

" split positions
set splitright " When splitting vertically, split to the right
set splitbelow " When splitting horizontally, split below
" :vertical ball " Rearrange splits VERTICALLY
" :ball " Rearrange splits HORIZONTALLY

" Resize the widows
" nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
" nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

" ... for normal mode
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

nnoremap <M-H> <C-w>H
nnoremap <M-J> <C-w>J
nnoremap <M-K> <C-w>K
nnoremap <M-L> <C-w>L

nnoremap <M-q> <C-w>q " Close current split
nnoremap <M-o> <C-w>o " Close all except current split
nnoremap <M-=> <C-w>= " Make all splits equal

" ... for insert mode
inoremap <M-h> <C-o><C-w>h
inoremap <M-j> <C-o><C-w>j
inoremap <M-k> <C-o><C-w>k
inoremap <M-l> <C-o><C-w>l

inoremap <M-H> <C-w>H
inoremap <M-J> <C-w>J
inoremap <M-K> <C-w>K
inoremap <M-L> <C-w>L

" ... for visual mode
vnoremap <M-h> <C-w>h
vnoremap <M-j> <C-w>j
vnoremap <M-k> <C-w>k
vnoremap <M-l> <C-w>l

vnoremap <M-H> <C-w>H
vnoremap <M-J> <C-w>J
vnoremap <M-K> <C-w>K
vnoremap <M-L> <C-w>L

" ... for terminal mode
if has('nvim')
  tnoremap <M-h> <C-\><C-n><C-w>h
  tnoremap <M-j> <C-\><C-n><C-w>j
  tnoremap <M-k> <C-\><C-n><C-w>k
  tnoremap <M-l> <C-\><C-n><C-w>l

  "works?
  tnoremap <M-H> <C-\><C-n><C-w>H
  tnoremap <M-J> <C-\><C-n><C-w>J
  tnoremap <M-K> <C-\><C-n><C-w>K
  tnoremap <M-L> <C-\><C-n><C-w>L
endif

" ------- "
" tabs "
" ------- "
" nmap <silent> tt :tabnew<CR>
" breaks 'tt' in insert mode!
" imap <silent> tt :<Esc>tabnew<CR>

nmap <silent> <Leader>tt :tabnew<CR>
imap <silent> <Leader>tt :tabnew<CR>

" nmap <silent> <Leader><Tab> :tabnew<CR>
" imap <silent> <Leader><Tab> :<Esc>tabnew<CR>

" g conflicts with coc
" w conflicts with ale (not using it now though)
" nmap <silent> [w :tabprevious<CR>
" nmap <silent> ]w :tabnext<CR>
" nmap <silent> [W :tabrewind<CR>
" nmap <silent> ]W :tablast<CR>

nmap <silent> [<Tab>   :tabprevious<CR>
nmap <silent> ]<Tab>   :tabnext<CR>
nmap <silent> [<S-Tab> :tabrewind<CR>
" nmap <silent> [<S-Tab> :tabfirst<CR>
nmap <silent> ]<S-Tab> :tablast<CR>

nmap <silent> <Leader><Tab> :tabs<CR>

" let notabs = 0
" nnoremap <silent> <F8> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>

" nnoremap <Leader>o o<Esc>^Da
" nnoremap <Leader>O O<Esc>^Da

" ------- "
" Folding "
" ------- "
" nnoremap <space> za
" vnoremap <space> zf


" ------------- "
" Terminal mode "
" ------------- "


if has('nvim')
" Leaving terminal emulation with Esc as well
  tnoremap <Esc> <C-\><C-n>
  " For sending a literal <Esc> to the running process
  tnoremap <C-v><Esc> <Esc>

    
  augroup neovim_terminal
      autocmd!
      " Enter Terminal-mode (insert) automatically
    autocmd TermOpen term://* startinsert
      " Disables number lines on terminal buffers
      autocmd TermOpen * :set nonumber norelativenumber
      " allows you to use Ctrl-c on terminal window
      autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
  augroup END

endif


" "" Git
" noremap <Leader>ga :Gwrite<CR>
" noremap <Leader>gc :Gcommit<CR>
" noremap <Leader>gsh :Gpush<CR>
" noremap <Leader>gll :Gpull<CR>
" noremap <Leader>gs :Gstatus<CR>
" noremap <Leader>gb :Gblame<CR>
" noremap <Leader>gd :Gvdiff<CR>
" noremap <Leader>gr :Gremove<CR>

" " session management
" nnoremap <Leader>so :OpenSession<Space>
" nnoremap <Leader>ss :SaveSession<Space>
" nnoremap <Leader>sd :DeleteSession<CR>
" nnoremap <Leader>sc :CloseSession<CR>

"" Set working directory
" nnoremap <Leader>. :lcd %:p:h<CR>
"" Set working directory (and print the result)
nnoremap <Leader>. :lcd %:p:h<CR>:pwd<CR>


"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" ------------------ "
" Highlighting Utils "
" ------------------ "
"" Highlighting lines with <Leader> l & <Leader> c
" https://vim.fandom.com/wiki/Highlight_current_line
" highlight the current line
nnoremap <silent> <Leader>l :exe "let m = matchadd('WildMenu','\\%" . line('.') . "l')"<CR>
" clear all the highlighted lines
nnoremap <silent> <Leader>c :call clearmatches()<CR>

" Highlight duplicate lines
function! HighlightRepeats() range
  let lineCounts = {}
  let lineNum = a:firstline
  while lineNum <= a:lastline
    let lineText = getline(lineNum)
    if lineText != ""
      let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
    endif
    let lineNum = lineNum + 1
  endwhile
  exe 'syn clear Repeat'
  for lineText in keys(lineCounts)
    if lineCounts[lineText] >= 2
      exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
    endif
  endfor
endfunction

command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()
