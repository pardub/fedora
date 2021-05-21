" fork from https://gist.github.com/miguelgrinberg/527bb5a400791f89b3c4da4bd61222e4
" for Fedora, run first sudo dnf install autoconf automake in order to install Ctags
" https://github.com/universal-ctags/ctag

" curl -LJO https://github.com/pardub/freebsd/edit/main/.vimrc
" git clone --depth 1 https://github.com/neoclide/coc.nvim.git

"save as root by redirecting to tee.
command! -nargs=0 Sw w !sudo tee % > /dev/null

call plug#begin()
Plug 'dense-analysis/ale' 
Plug 'psf/black' 
Plug 'davidhalter/jedi-vim'
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'sjl/gundo.vim'
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/indentpython.vim'

"Plug 'nvie/vim-flake8'
call plug#end()


""" always show the status bar
set laststatus=2

" turn on line numbering
set number
set relativenumber

""" to avoid pink tab completion with jedi-vim
set t_Co=256

""""""set color for Tmux
"set t_ut=

" sane text files
set fileformat=unix 
set encoding=utf-8 
set fileencoding=utf-8

" sane editing
set tabstop=4 
set shiftwidth=4 
set softtabstop=4 
set colorcolumn=80 
set expandtab
set viminfo='25,\"50,n~/.viminfo

""" auto-pairs
au FileType python let b:AutoPairs = AutoPairsDefine({"f'" : "'", "r'" : "'", "b'" : "'"})

""" word movement
imap <S-Left> <Esc>bi
nmap <S-Left> b
imap <S-Right> <Esc><Right>wi
nmap <S-Right> w

""" indent/unindent with tab/shift-tab
nmap <Tab> >>
nmap <S-tab> <<
imap <S-Tab> <Esc><<i
vmap <Tab> >gv
vmap <S-Tab> <gv


""" mouse
set mouse=a
let g:is_mouse_enabled = 1
noremap <silent> <Leader>m :call ToggleMouse()<CR>
function ToggleMouse()
    if g:is_mouse_enabled == 1
        echo "Mouse OFF"
        set mouse=
        let g:is_mouse_enabled = 0
    else
        echo "Mouse ON"
        set mouse=a
        let g:is_mouse_enabled = 1
    endif
endfunction


""" color scheme
syntax on
colorscheme onedark
filetype on
filetype plugin indent on

""" code folding
set foldmethod=indent
set foldlevel=99

""" wrap toggle
setlocal nowrap
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function ToggleWrap()
    if &wrap
        echo "Wrap OFF"
        setlocal nowrap
        set virtualedit=all
        silent! nunmap <buffer> <Up>
        silent! nunmap <buffer> <Down>
        silent! nunmap <buffer> <Home>
        silent! nunmap <buffer> <End>
        silent! iunmap <buffer> <Up>
        silent! iunmap <buffer> <Down>
        silent! iunmap <buffer> <Home>
        silent! iunmap <buffer> <End>
    else
        echo "Wrap ON"
        setlocal wrap linebreak nolist
        set virtualedit=
        setlocal display+=lastline
        noremap  <buffer> <silent> <Up>   gk
        noremap  <buffer> <silent> <Down> gj
        noremap  <buffer> <silent> <Home> g<Home>
        noremap  <buffer> <silent> <End>  g<End>
        inoremap <buffer> <silent> <Up>   <C-o>gk
        inoremap <buffer> <silent> <Down> <C-o>gj
        inoremap <buffer> <silent> <Home> <C-o>g<Home>
        inoremap <buffer> <silent> <End>  <C-o>g<End>
    endif
endfunction

""" move through split windows
nmap <leader><Up> :wincmd k<CR>
nmap <leader><Down> :wincmd j<CR>
nmap <leader><Left> :wincmd h<CR>
nmap <leader><Right> :wincmd l<CR>

""" move through buffers
nmap <leader>[ :bp!<CR>
nmap <leader>] :bn!<CR>
nmap <leader>x :bd<CR>

""" restore place in file from previous session
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""" file browser
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let NERDTreeMinimalUI = 1
let g:nerdtree_open = 0
map <leader>z :call NERDTreeToggle()<CR>
function NERDTreeToggle()
    NERDTreeTabsToggle
    if g:nerdtree_open == 1
        let g:nerdtree_open = 0
    else
        let g:nerdtree_open = 1
        wincmd p
    endif
endfunction

function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction
autocmd VimEnter * call StartUp()


""" Plugin Git undo "Gundo"
nnoremap <F6> :GundoToggle<CR>

"" fix error message "gundo requires vim to be compiled with python 2.4+"
" see https://vi.stackexchange.com/questions/6558/gundo-plugin-requires-python-2-4-when-version-2-7-is-installed
"
if has('python3')
    let g:gundo_prefer_python3 = 1
endif


""" lightline
set noshowmode
let g:lightline = { 'colorscheme': 'onedark' }


""" Black Settings

"To run Black on save
"autocmd BufWritePre *.py execute ':Black'

"To run Black on a key press
nnoremap <F9> :Black<CR>


""" Flake 8 settings

"" To run Flake8 on save
"autocmd BufWritePost *.py call Flake8()

"To run Flake8 on a key press
nnoremap <F5> :flake8<CR>

"""Ale settings
map <C-e> <Plug>(ale_next_wrap)
map <C-r> <Plug>(ale_previous_wrap


"" Change default error markers
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'

"" Disable linting when opening a new file 
"let g:ale_lint_on_enter = 0

"" linting on save
"let g:ale_lint_on_save = 1

"" Enable linting with Flake8 for Python
"let g:ale_linters = {'python' :['flake8']}

"" Enable fixing with Black for Python
"let g:ale_fixers = {'*':[], 'python': ['black']}


""" tags
map <leader>t :TagbarToggle<CR>

""" copy, cut and paste
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa


" disable autoindent when pasting text
" source: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()


set showcmd             " show command in bottom bar
set autoindent          " Respect indentation when starting a new line.
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase          " do case insensitive search
set backspace=2         " Fix backspace behavior on most terminals.

""" remap j/k/$/0 to make j/k/$/0 move by virtual lines instead of physical lines
command! -nargs=* Wrap set wrap linebreak nolist
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
noremap <silent> <expr> 0 (v:count == 0 ? 'g0' : '0')
noremap <silent> <expr> $ (v:count == 0 ? 'g$' : '$')
