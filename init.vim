call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter' " TODO : not sure what this even does...
" TODO: CHADTree?

" LSP / autocomplete / etc

" LSP tools
Plug 'neovim/nvim-lspconfig'
Plug 'neovim/nvim-lsp'
Plug 'davidhalter/jedi-vim'  " The docs for pyls say that the base language server depends on this for definitions

" Language specific plugins 
Plug 'cespare/vim-toml'

" Remote debug plugin 
Plug 'jamestthompson3/nvim-remote-containers'

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

" Python interpreter
if has("mac")
    let g:python3_host_prog = system('which python') 
else
    let g:python3_host_prog = '/usr/bin/python3'
endif

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


" ==== LANGUAGE SERVERS ==== 
" Keybindings for LSP functions

lua << EOF
local nvim_lsp = require('lspconfig')
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {'pyright', 'pyls', 'rust_analyzer', 'ccls'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

EOF

" Completion settings 
" Actually I find auto complete (or at least automatic auto complete) a
" massive pain.
let g:jedi#popup_on_dot = 0

" Syntax highlighting for llvm assembly files
augroup filetype
    au! BufRead,BufNewFile *.ll     set filetype=llvm
augroup END

" Syntax highlighting for tablegen description files
augroup filetype
    au! BufRead,BufNewFile *.td     set filetype=tablegen
augroup END

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
