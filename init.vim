call plug#begin('~/.local/share/nvim/plugged')

Plug 'davidhalter/jedi-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'machakann/vim-highlightedyank'

" LSP / autocomplete / etc
Plug 'neoclide/coc.nvim'
"Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}  

" Language plugins
Plug 'jackguo380/vim-lsp-cxx-highlight'

" Colorscheme 
Plug 'morhetz/gruvbox'
Plug 'Lokaltog/vim-distinguished'
Plug 'nanotech/jellybeans.vim'

call plug#end()

" Other vim stuff 
set number 
set hlsearch
set incsearch
set shiftwidth=4
set tabstop=4
set et|retab 
set linebreak
set wrap

" 256 color schemes 
set t_Co=256
colorscheme jellybeans
"colorscheme distinguished

" airline theme 
let g:airline_theme='ayu_dark'

filetype plugin indent on 
syntax on

" Cursor
set guicursor=i:block

" Remap some keys
nnoremap <CR> :noh<CR><CR>
nnoremap <Up> gk
nnoremap <Down> gj

" Quick spelling (Jonas @ stackoverflow)
imap <c-L> <c-g>u<Esc>[s1z=`]a,<c-g>u
imap <c-L> [s1z-`<c-o>

" Toggle spellcheck
nnoremap <F5> :setlocal spell! spelllang=en_gb<CR>

" Syntax highlighting for llvm assembly files
augroup filetype
    au! BufRead,BufNewFile *.ll     set filetype=llvm
augroup END

" Syntax highlighting for tablegen description files
augroup filetype
    au! BufRead,BufNewFile *.td     set filetype=tablegen
augroup END
