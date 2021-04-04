if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

syntax on

set ignorecase
set smartcase

" coc vonfig
" some servers have issues with backup files, see #649.
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
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Remove fold column
set foldcolumn=0

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

command! -nargs=0 Prettier :CocCommand prettier.formatFile

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" end of coc config

set encoding=utf-8
let &t_Co=256
set number
let g:ycm_autoclose_preview_window_after_completion=1
let python_highlight_all=1
let g:airline_powerline_fonts = 1

imap <C-l> <Plug>(coc-snippets-expand)

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'

Plug 'udalov/kotlin-vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'fwcd/kotlin-language-server'
Plug 'stephpy/vim-yaml'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'ryanoasis/vim-devicons'
" Plug 'chiel92/vim-autoformat'

call plug#end()

colorscheme gruvbox
set background=dark

let g:coc_global_extensions = [
            \ 'coc-omnisharp',
            \ 'coc-rust-analyzer', 
            \ 'coc-pairs', 
            \ 'coc-docker', 
            \ 'coc-java', 
            \ 'coc-prettier', 
            \ 'coc-json', 
            \ 'coc-eslint',
            \ 'coc-tsserver', 
            \ 'coc-css', 
            \ 'coc-python', 
            \ 'coc-angular', 
            \ 'coc-yaml', 
            \ 'coc-vimlsp', 
            \ 'coc-sh', 
            \ 'coc-snippets', 
            \ 'coc-explorer',
            \ ]

" Split navigations
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>

" coc-explorer opening
:nmap <space>e :CocCommand explorer<CR>

" Use ctrl + / as a comment
map <space>/ :Commentary<CR>

" Spaces and tabs 
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space

" FZF config
noremap <silent> <C-p> :Files<CR>
noremap <silent> <C-o> :Buffers<CR>
noremap <C-f> :Files<CR>
noremap <C-i> :GFiles<CR>

" Auto format java file
command! -nargs=0 Format :call CocAction('format')
noremap <silent> <C-A-L> :Format<CR>:w<CR>

" Create variable
noremap <silent> <C-A-V> :execute "normal! Ivar variableName = <C-v><esc>bbciw "<CR>i
" noremap <silent> <C-A-B> :execute "normal! viwy^i<C-v><esc>p variableName = "<CR>i

nmap <silent><F2> <Plug>(coc-rename)

" Intellij alternative for alt enter, generate to string etc
nmap <silent><a-cr> <Plug>(coc-codeaction)

" GoTo code navigations
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

set pyx=3
