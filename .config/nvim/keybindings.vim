syntax on
filetype plugin indent on
"Map Leader to Space
let mapleader = "\<Space>"
" Lsp Trouble keys
nnoremap <leader>xx <cmd>LspTroubleToggle<cr>
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
nmap <leader>gs :G<CR>
nnoremap <Leader>gaf :Gw<CR>      






" Rust
let g:rust_recommended_style = 0
let g:rustfmt_autosave = 0






" Creates vertical and horizontal plits with ,+v/h
nnoremap ,v <C-w>v
nnoremap ,h <C-w>s






" Yank highlight
let g:highlightedyank_highlight_duration = 0200






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




" ========= Window resizing
let g:lens#height_resize_max = 30






nnoremap <C-n> :Hexplore<CR>






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






"Netrw config:
let g:netrw_liststyle = 1
let g:netrw_bnner = 0
let g:netrw_browse_split = 2
let g:netrw_winsize = 5






"Sneak
let g:sneak#s_next = 1






"Replacer
nmap <leader>h :lua require("replacer").run()<cr>






" Dashboard
let g:dashboard_custom_header =<< trim END
=================     ===============     ===============   ========  ========
\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //
||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||
|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||
||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||
|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||
||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||
|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||
||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||
||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||
||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||
||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||
||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||
||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||
||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||
||.=='    _-'                                                     `' |  /==.||
=='    _-'                        N E O V I M                         \/   `==
\   _-'                                                                `-_   /
 `''                                                                      ``'
END

" lua << END
" vim.g.dashboard_custom_header = {
"        "            :h-                                  Nhy`               ",
"        "           -mh.                           h.    `Ndho               ",
"        "           hmh+                          oNm.   oNdhh               ",
"        "          `Nmhd`                        /NNmd  /NNhhd               ",
"        "          -NNhhy                      `hMNmmm`+NNdhhh               ",
"        "          .NNmhhs              ```....`..-:/./mNdhhh+               ",
"        "           mNNdhhh-     `.-::///+++////++//:--.`-/sd`               ",
"        "           oNNNdhhdo..://++//++++++/+++//++///++/-.`                ",
"        "      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:       ",
"        " .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+        ",
"        " h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`         ",
"        " hd+` -NNNy`./dNNNNNhhhh+-://///   -+ooo:`  ::-:+////++///:`        ",
"        " /Nmhs+oss-:++/dNNNmhho:--::///   /mmmmmmo  ../-///++///////.       ",
"        "  oNNdhhhhhhhs//osso/:---:::///   /myyyyso  ..o+-//////////:/.      ",
"        "   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.     ",
"        "     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`    ",
"        "       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:    ",
"        "       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`   ",
"        "       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:   ",
"        "       //+++//++++++////+++///::--                 .::::-------::   ",
"        "       :/++++///////////++++//////.                -:/:----::../-   ",
"        "       -/++++//++///+//////////////               .::::---:::-.+`   ",
"        "       `////////////////////////////:.            --::-----...-/    ",
"        "        -///://////////////////////::::-..      :-:-:-..-::.`.+`    ",
"        "         :/://///:///::://::://::::::/:::::::-:---::-.-....``/mm`   ",
"        "           ::::://::://::::::::::::::----------..-:....`.../Nmhd+o/ ",
"        "            -/:::-:::::---://:-::-::::----::---.-.......`-/oNN   `` ",
"        "           s-`::--:::------:////----:---.-:::...-.....`./:          ",
"        "          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`           ",
"        "         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-              ",
"        "        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                ",
"        "                        .-:mNdhh:.......--::::-`                    ",
"        "                           yNh/..------..`                          ",
"        "                                                                    ",
"        "                             N E O V I M                             ",
" }
" END
let g:dashboard_default_executive ='fzf'


let g:vim_markdown_folding_disabled = 1




let g:vista_default_executive = 'ctags'



function! s:better_sub() abort
    let reg = getreg(0)
    let word = expand('<cword>')
    
    call maktaba#buffer#Substitute(word, reg)

endfunc

nnoremap <leader>r :call <SID>better_sub()<CR>




" Ocaml
" let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
" execute "set rtp+=" . g:opamshare . "/merlin/vim"
" set rtp^="/home/luis/.opam/4.11.1/share/ocp-indent/vim"



nnoremap <leader>= :Tabularize /=<CR>
nnoremap <leader>- :Tabularize /-><CR>
nnoremap <leader>, :Tabularize /,<CR>
nnoremap <leader># :Tabularize /#-}<CR>

" buffer nav
nnoremap <leader>b :ls<CR>:b<Space>a
