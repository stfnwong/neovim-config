call plug#begin('~/.local/share/nvim/plugged')

"Plug 'davidhalter/jedi-vim"'       " TODO: why so many autocompletes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
" TODO: CHADTree?

" LSP / autocomplete / etc
"Plug 'neoclide/coc.nvim', { 'branch': 'release'}
"Plug 'prabirshrestha/vim-lsp'
"Plug 'dense-analysis/ale'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'cespare/vim-toml'

" LSP tools
Plug 'neovim/nvim-lspconfig'

" Project Management 
Plug 'ahmedkhalf/project.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'Lokaltog/vim-distinguished'
Plug 'nanotech/jellybeans.vim'

call plug#end()

" Generic vim stuff 
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
let g:airline_theme='badwolf'

filetype plugin indent on 
syntax on

" Cursor
set guicursor=i:block

" Try and map cnext, cprev (TODO: dont keep these specific keys)
"nnoremap <silent> <C-n> :cnext <CR>
"nnoremap <silent> <C-p> :cprev <CR>

" Remap some keys
nnoremap <CR> :noh<CR><CR>
nnoremap <Up> gk
nnoremap <Down> gj

" Quick spelling (Jonas @ stackoverflow)
imap <c-L> <c-g>u<Esc>[s1z=`]a,<c-g>u
imap <c-L> [s1z-`<c-o>

" Toggle spellcheck
nnoremap <F5> :setlocal spell! spelllang=en_gb<CR>

" FZF customization
let g:fzf_preview_window = ['right:32%', 'crtl-/']      " make default window smaller


" Language server configs 
" PYRIGHT
lua << EOF
    require'lspconfig'.pyright.setup{}
EOF

lua << EOF
    require'lspconfig'.rust_analyzer.setup{}
EOF


" Syntax highlighting for llvm assembly files
augroup filetype
    au! BufRead,BufNewFile *.ll     set filetype=llvm
augroup END

" Syntax highlighting for tablegen description files
augroup filetype
    au! BufRead,BufNewFile *.td     set filetype=tablegen
augroup END

" Setup for vim-lsp 
"if executable('ccls')
"    au User lsp_setup call lsp#register_server({
"                \ 'name': 'ccls',
"                \ 'cmd': {server_info->['ccls']},
"                \ 'root_uri': {server_info->lsp#utils#path_to_uri(
"                \   lsp#utils#find_nearest_parent_file_directory(
"                \      lsp#utils#get_buffer_path(), ['.ccls', 'compile_commands.json', '.git/']))}
"                \ 'initialization_options': {
"                \   'highlight': { 'lsRanges': v:true},
"                \   'cache': {'directory': stdpath('cache') . '/ccls'},
"                \ }
"                \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc', 'hh', 'hpp'],
"                \ })
"endif

" Use gutentags for tags 
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" Generate extra helpfiles (at least for ALE)
" Plugins need to be added to runtimepath before helptags can be generated
packloadall
" Now load all helptags after plugins have been loaded 
silent! helptags ALL
