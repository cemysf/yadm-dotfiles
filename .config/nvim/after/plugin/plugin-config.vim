" -----------------------------------
" Plugin configuration
" ----------------------------------- 

" ---------
" NEW fzf.vim 
" ---------
if has('nvim') || has('gui_running')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif


" All files
command! -nargs=? -complete=dir AF
  \ call fzf#run(fzf#wrap(fzf#vim#with_preview({
  \   'source': 'fd --type f --hidden --follow --exclude .git --no-ignore . '.expand(<q-args>)
  \ })))

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Terminal buffer options for fzf
autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu

if has('nvim') && exists('&winblend') && &termguicolors
  set winblend=20

  hi NormalFloat guibg=None
  if exists('g:fzf_colors.bg')
    call remove(g:fzf_colors, 'bg')
  endif

  if stridx($FZF_DEFAULT_OPTS, '--border') == -1
    let $FZF_DEFAULT_OPTS .= ' --border'
  endif

  function! FloatingFZF()
    let width = float2nr(&columns * 0.8)
    let height = float2nr(&lines * 0.6)
    let opts = { 'relative': 'editor',
               \ 'row': (&lines - height) / 2,
               \ 'col': (&columns - width) / 2,
               \ 'width': width,
               \ 'height': height }

    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
endif

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)


" <leader><leader> -> File explorer preview!
" nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"


" Search files
nnoremap <C-p> :<C-u>FZF<CR>
nnoremap <silent> <leader>e :FZF -m<CR>
" cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>


" <leader>C -> Change colors
nnoremap <silent> <Leader>C        :Colors<CR>

" <leader><Enter> -> Search Buffers
" nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>B  :Buffers<CR>
" nnoremap <silent> <leader>b :Buffers<CR>

" <leader><Enter> -> Search lines
nnoremap <silent> <Leader>L        :Lines<CR>
" <leader>b to search through history with FZF
" nmap <leader>y :History:<CR>

" History
nnoremap <silent> q: :History:<CR>
nnoremap <silent> q/ :History/<CR>

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>

inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
inoremap <expr> <c-x><c-d> fzf#vim#complete#path('blsd')
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" nmap <leader><tab> <plug>(fzf-maps-n)
" xmap <leader><tab> <plug>(fzf-maps-x)
" omap <leader><tab> <plug>(fzf-maps-o)

function! s:plug_help_sink(line)
  let dir = g:plugs[a:line].dir
  for pat in ['doc/*.txt', 'README.md']
    let match = get(split(globpath(dir, pat), "\n"), 0, '')
    if len(match)
      execute 'tabedit' match
      return
    endif
  endfor
  tabnew
  execute 'Explore' dir
endfunction

command! PlugHelp call fzf#run(fzf#wrap({
  \ 'source': sort(keys(g:plugs)),
  \ 'sink':   function('s:plug_help_sink')}))


" ---------
" fzf.vim 
" ---------
" 

" " Search with icons!
" function! Fzf_dev()
"   function! s:files()
"     let files = split(system($FZF_DEFAULT_COMMAND), '\n')
"     return s:prepend_icon(files)
"   endfunction

"   function! s:prepend_icon(candidates)
"     let result = []
"     for candidate in a:candidates
"       let filename = fnamemodify(candidate, ':p:t')
"       let icon = WebDevIconsGetFileTypeSymbol(filename, isdirectory(filename))
"       call add(result, printf("%s %s", icon, candidate))
"     endfor

"     return result
"   endfunction

"   function! s:edit_file(item)
"     let parts = split(a:item, ' ')
"     let file_path = get(parts, 1, '')
"     execute 'silent e' file_path
"   endfunction

"   call fzf#run({
"         \ 'source': <sid>files(),
"         \ 'sink':   function('s:edit_file'),
"         \ 'options': '-m -x +s',
"         \ 'down':    '40%' })
" endfunction




" command! FilesWithIcon :call Fzf_dev()


" " export FZF_DEFAULT_COMMAND='rg --files' # smarter about ignoring some files
" " making it faster
" set wildmode=list:longest,list:full
" set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
" let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"


" " The Silver Searcher
" if executable('ag')
"   let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
"   set grepprg=ag\ --nogroup\ --nocolor
" endif

" " ripgrep
" if executable('rg')
"   let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
"   set grepprg=rg\ --vimgrep
"   command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
" endif

" " style
" let g:fzf_layout = { 'window': '10split enew' }


" Mappings
" <ctrl-p> or <leader>e to find files (what's the difference?)
" nnoremap <C-p> :<C-u>FZF<CR>
" nnoremap <silent> <leader>e :FZF -m<CR>
" cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" <leader>b to search buffers
" nnoremap <silent> <leader>b :Buffers<CR>
" <leader>b to search through history with FZF
" nmap <leader>y :History:<CR>

" ---------
" Projectionist
" ---------
" You need to make a .projections JSON file. Go back to this in the future...
" Tips 8 & 9


" ---------
" Ultisnips
" ---------
" Where should it look for snippet files (coc-snippets also has paths)
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mycoolsnippets"]

" Trigger configuration. You need to change this to something else than <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<space>"
" let g:UltiSnipsExpandTrigger="<CR>"
let g:UltiSnipsExpandTrigger="<tab>"

let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"

let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" ---------
" ALE
" ---------


" For JavaScript files, use `eslint` (and only eslint)
" linters.vim
" let g:ale_linters = {
" \   'javascript': ['eslint'],
" \ }

" traversal.vim
" Mappings in the style of unimpaired-next
" nmap <silent> [W <Plug>(ale_first)
" nmap <silent> [w <Plug>(ale_previous)
" nmap <silent> ]w <Plug>(ale_next)
" nmap <silent> ]W <Plug>(ale_last)
" toggle.vim
" Mappings inspired by unimpaired-toggling
" nnoremap [oa :ALEEnable<CR>
" nnoremap ]oa :ALEDisable<CR>
" nnoremap =oa :ALEToggle<CR>

" manual.vim
" nnoremap <Leader>l :ALELint<CR>
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_save = 0
" let g:ale_lint_on_enter = 0
" let g:ale_lint_on_filetype_changed = 0

" " automatic.vim
" let g:ale_lint_on_text_changed = 'always' " default
" let g:ale_lint_on_save = 1                " default
" let g:ale_lint_on_enter = 1               " default
" let g:ale_lint_on_filetype_changed = 1    " default
" let g:ale_sign_column_always = 1

" ---------
" nvim-gdb
" ---------
" To disable the plugin
" let g:loaded_nvimgdb = 1

" For more info:
" https://github.com/sakhnik/nvim-gdb


" ---------
" COC (Conquer Of Completion)
" ---------
source $HOME/.config/nvim/after/plugin/coc.vim

" nvim-editcommand 
" -----------------
" " Editing terminal-mode commands in buffer using <C-x><C-e>
" call minpac#add('brettanomyces/nvim-editcommand')
" let g:editcommand_prompt = '>'   
" The default mapping is <c-x><c-e>, to change it:
" let g:editcommand_no_mappings = 1    " default is 0
" tmap <C-x> <Plug>EditCommand         " default is <c-x><c-e>



" ---------
" nvim-gdb
" ---------
" We're going to define single-letter keymaps, so don't try to define them
" in the terminal window.  The debugger CLI should continue accepting text commands.
" function! NvimGdbNoTKeymaps()
"   tnoremap <silent> <buffer> <esc> <c-\><c-n>
" endfunction

" let g:nvimgdb_config_override = {
"   \ 'key_next': 'n',
"   \ 'key_step': 's',
"   \ 'key_finish': 'f',
"   \ 'key_continue': 'c',
"   \ 'key_until': 'u',
"   \ 'key_breakpoint': 'b',
"   \ 'set_tkeymaps': "NvimGdbNoTKeymaps",
"   \ }

" ---------
" Vimspector
" ---------

let g:vimspector_enable_mappings = 'HUMAN'
