" Global extension names to install when they aren't installed.
" " See a list here: https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions
let g:coc_global_extensions = [
      \'coc-actions', 
      \'coc-git', 
      \'coc-html',
      \'coc-css',
      \'coc-prettier',
      \'coc-eslint', 
      \'coc-clangd',
      \'coc-jedi',
      \'coc-markdownlint',
      \'coc-python',
      \'coc-sh',
      \'coc-json', 
      \'coc-yaml',
      \'coc-xml',
      \'coc-snippets',
      \'coc-lists',
      \'coc-highlight',
      \]

      " only works with  
      " conflicts with <leader>f for fzf


" Other extensions to explore...
" Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}

" Plug 'neoclide/coc-tslint', {'do': 'yarn install --frozen-lockfile'}

" 'neoclide/coc-lists' mru and stuff
" 'neoclide/coc-highlight'" color highlighting


" coc-floaterm for vim-floaterm integration
" coc-explorer file explorer extension

" coc-actions Actions menu for Neovim

" coc-bookmark bookmark extension

" coc-browser for browser words completion

" coc-cmake for cmake code completion
" coc-cssmodules css modules intellisense.

" coc-fzf-preview provide powerful fzf integration.

" coc-highlight provides default document symbol highlighting and color support.
" coc-lists provides some basic lists like fzf.vim.
" coc-stylelintplus for linting CSS and CSS preprocessed formats
" coc-stylelint for linting CSS and CSS preprocessed formats
" coc-snippets provides snippets solution.
" coc-spell-checker A basic spell checker that works well with camelCase code
" coc-tabnine for tabnine.
" coc-tailwindcss for tailwindcss.
" coc-tasks for asynctasks.vim integration
" coc-template templates extension for file types
" coc-texlab for LaTex using TexLab.
" coc-tsserver for javascript and typescript.
" coc-vimlsp for viml.
" coc-yank provides yank highlights & history.



" Opening the configuration file
" Use the command :CocConfig to open your user configuration file, you can create a shortcut for the command like this:
function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use ':C' to open coc config
call SetupCommandAbbrs('C', 'CocConfig')

" --------------------

" https://www.chrisatmachine.com/Neovim/04-vim-coc/
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Just use the defaults... <c-n><c-p>
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" <TAB> is the same as <c-i>! https://github.com/neoclide/coc.nvim/issues/1089
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <leader>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions.
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <leader>ce  :<C-u>CocList extensions<cr>
" Show commands.
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
nnoremap <silent> <leader>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent> <leader>ck  :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
nnoremap <silent> <leader>cp  :<C-u>CocListResume<CR>


" ---------------------------------------------------------------------------- "
" Prettier config
" ---------------------------------------------------------------------------- "
" Supports only: javascript, javascriptreact, typescript, typescriptreact, json and graphql

" Use ':Prettier' to format current buffer
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Remap keys
vmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  :CocCommand prettier.formatFile<cr>

