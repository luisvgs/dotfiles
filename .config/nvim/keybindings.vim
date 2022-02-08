syntax on
filetype plugin indent on
xnoremap <leader>( <ESC>`>a)<ESC>`<i(<ESC>
"Bind :w to save with ctrl+s
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a
inoremap <C-e> <C-o>A
" Stop text search highlight
map <esc> :noh<cr>

" the following will make an exception just for make
" if we ever start using just spaces, as perhaps we should
autocmd FileType make setlocal noexpandtab


" Keep star command in the same position
nnoremap * m`:keepjumps normal! *``<cr>

"Sends any deleted text to the black hole register. 
"nnoremap d "_d
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

nnoremap <leader>d ""d
nnoremap <leader>D ""D
vnoremap <leader>d ""d

"FZF Keybindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-i': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~25%' }
let g:fzf_preview_window = []




autocmd FileType haskell setlocal expandtab
autocmd FileType haskell let b:autoformat_autoindent = 0

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction



nnoremap <leader>z viw<esc>a)<esc>hbi(<esc>lel
nnoremap <leader>cb viw<esc>a}<esc>hbi{<esc>lel


"Replacer
nmap <leader>h :lua require("replacer").run()<cr>


let g:vim_markdown_folding_disabled = 1



function! s:better_sub() abort
    let reg = getreg(0)
    let word = expand('<cword>')
    
    call maktaba#buffer#Substitute(word, reg)

endfunc

nnoremap <leader>r :call <SID>better_sub()<CR>

function! Spawn_note_window() abort
  let path = "~/notes/"
  let file_name = path.strftime("note-%d-%m-%y.wiki")
  " Empty buffer
  let buf = nvim_create_buf(v:false, v:true)
  " Get current UI
  let ui = nvim_list_uis()[0]
  " Dimension
  let width = (ui.width/2)
  let height = (ui.height/2)
  " Options for new window
  let opts = {'relative': 'editor',
              \ 'width': width,
              \ 'height': height,
              \ 'col': (ui.width - width)/2,
              \ 'row': (ui.height - height)/2,
              \ 'anchor': 'NW',
              \ 'style': 'minimal',
              \ 'border': 'single',
              \ }
  " Spawn window
  let win = nvim_open_win(buf, 1, opts)
  " Now we can actually open or create the note for the day?
  if filereadable(expand(file_name))
    execute "e ".fnameescape(file_name)
    let column = 80
    execute "set textwidth=".column
    execute "set colorcolumn=".column
    execute "norm Go"
    execute "norm zz"
    execute "startinsert"
  else
    execute "e ".fnameescape(file_name)
    let column = 80
    execute "set textwidth=".column
    execute "set colorcolumn=".column
    execute "norm Gi= Notes for ".strftime("%d-%m-%y")." ="
    execute "norm G2o"
    execute "norm Gi- " 
    execute "norm zz"
    execute "startinsert"
  endif
endfunction
nmap <silent> nn :call Spawn_note_window() <CR>
