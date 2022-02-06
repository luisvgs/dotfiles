syntax on
filetype plugin indent on
"Map Leader to Space
let mapleader = "\<Space>"
" Lsp Trouble keys
nnoremap <leader>xx <cmd>TroubleToggle<cr>
xnoremap <leader>( <ESC>`>a)<ESC>`<i(<ESC>
"source vim config file with leader + s
nnoremap <leader>s :source %<CR>
"source and PlugInstall
nnoremap <silent><leader>1 :source ~/.vimrc \| :PlugInstall<CR>
nnoremap <silent><leader>2 :source ~/.vimrc \| :PlugClean<CR>
"Switch between buffers quickly
nnoremap <leader><leader> <c-^>
"Bind :w to save with ctrl+s
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a
inoremap <C-e> <C-o>A
" Stop text search highlight
map <esc> :noh<cr>





" the following will make an exception just for make
" if we ever start using just spaces, as perhaps we should
autocmd FileType make setlocal noexpandtab






" Changing paste keys just for our own sanity.
noremap p gp
noremap P gP
noremap gp p
noremap gP P
noremap <leader>y "+y
noremap <leader>p "+p






" Keep star command in the same position
nnoremap * m`:keepjumps normal! *``<cr>






"Easier buffer navigation
"nnoremap <Leader>e :bn<CR>
"nnoremap <Leader>w :bp<CR>
nnoremap <Leader>q :bd!<CR>
map <C-w> :bprevious<CR>
map <C-e> :bnext<CR>
map <C-q> :bq<CR>






"Close split with ctrl-q
map <C-q> :q<CR>






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
map <C-F> :Files %:p:h<CR>
map <C-B> :Buffers<CR>
map <C-P> :History<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-i': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~35%' }
let g:fzf_preview_window = []



"" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>





"Clang formating
nnoremap <Leader>f :<C-u>ClangFormat<CR>






" Window resizing alternative using arrow keys
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>






"====== Git config
" nmap <leader>gs :G<CR>
" nnoremap <Leader>gaf :Gw<CR>      




" Rust
let g:rust_recommended_style = 0
let g:rustfmt_autosave = 0






" Creates vertical and horizontal plits with ,+v/h
nnoremap ,v <C-w>v
nnoremap ,h <C-w>s






" Yank highlight
let g:highlightedyank_highlight_duration = 0100






" Useful keybindings
nmap <C-Y> :RustFmt<CR>






"============ Haskell ===============
let g:haskell_classic_highlighting = 0
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_indent_in = 4
let g:haskell_indent_guard = 3
let g:haskell_indent_case_alternative = 1
let g:cabal_indent_section = 2

autocmd FileType haskell setlocal expandtab
autocmd FileType haskell let b:autoformat_autoindent = 0





" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction








"=================== IDRIS ==================
let g:idris_indent_if = 3
let g:idris_indent_let = 4
let g:idris_indent_where = 6
let g:idris_indent_do = 3
let g:idris_indent_rewrite = 8












" LSP code actions
set updatetime=300

nnoremap <leader>z viw<esc>a)<esc>hbi(<esc>lel
nnoremap <leader>cb viw<esc>a}<esc>hbi{<esc>lel






"Moves Blocks of code in visual mode 
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv 






"Identation with < and >
vnoremap < <gv
vnoremap > >gv






" Follow Rust code style rules
" au Filetype rust source ~/.config/nvim/scripts/spacetab.vim
" autocmd FileType scala set shiftwidth=4|set expandtab







autocmd FileType javascript set shiftwidth=1|set expandtab| set shiftwidth=2
autocmd FileType javascriptreact set shiftwidth=1|set expandtab| set shiftwidth=2







"Replacer
nmap <leader>h :lua require("replacer").run()<cr>



let g:vim_markdown_folding_disabled = 1






function! s:better_sub() abort
    let reg = getreg(0)
    let word = expand('<cword>')
    
    call maktaba#buffer#Substitute(word, reg)

endfunc

nnoremap <leader>r :call <SID>better_sub()<CR>




nnoremap <leader>= :Tabularize /=<CR>
nnoremap <leader>- :Tabularize /-><CR>
nnoremap <leader>, :Tabularize /,<CR>
nnoremap <leader># :Tabularize /#-}<CR>

" buffer nav
nnoremap <leader>b :ls<CR>:b<Space>a

" Pounce
nnoremap <leader>p <cmd>Pounce<cr>

" Focus
nnoremap <silent><leader>l <cmd>FocusSplitRight<cr> 
nnoremap <silent><leader>j <cmd>FocusSplitDown<cr> 
nnoremap <silent><leader>k <cmd>FocusSplitUp<cr> 
" nnoremap <silent><leader>j<cmd>FocusSplitLeft<cr> 


nnoremap <silent><leader>gs <cmd>G<cr> 
nnoremap <silent><leader>gc <cmd>Git commit<cr> 
nnoremap <silent><leader>gd <cmd>Git diff<cr> 
nnoremap <silent><leader>gl<cmd>Git log<cr> 



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
