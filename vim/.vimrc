" vim-plug plugins
call plug#begin()
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'hashivim/vim-terraform'
Plug 'tomasiser/vim-code-dark'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-surround'
Plug 'stephpy/vim-yaml'
Plug 'psf/black'
Plug 'jiangmiao/auto-pairs'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

syntax on
colorscheme codedark

" Leader Key
let mapleader = "\<space>"

" Set
set nu
set clipboard=unnamed,unnamedplus
set hlsearch
set splitbelow
set splitright
set autoread
set autowrite
set nofixendofline
set backspace=indent,eol,start
set foldmethod=syntax
set foldlevel=3

" Remap
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-n> :cnext<CR>
nnoremap <C-m> :cprevious<CR>
nnoremap <leader>j :call NumberToggle()<CR>
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Rust
let g:rustfmt_autosave = 1

" Go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_def_mapping_enabled = 1
let g:go_def_mode = 'gopls'
let g:go_fmt_command = "goimports"

autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)
autocmd FileType go set tabstop=4 shiftwidth=4

" Python
autocmd BufWritePre *.py execute ':Black'

" Yaml
autocmd FileType yaml set foldmethod=indent

" Terraform
let g:terraform_fmt_on_save = 1
let g:terraform_align = 1

" Indents
let g:indentLine_char = "|"

" --- Functions ---
" Relative/absolute number lines
function! NumberToggle()
	if(&nu == 1)
		set nu!
		set rnu
	else
		set nornu
		set nu
	endif
endfunction
set regexpengine=0
set tags+=./tags;$HOME


" LSP Settings
if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer> <leader>o <plug>(lsp-preview-focus)
    nnoremap <buffer> <expr> <c-b> lsp#scroll(+4)
    nnoremap <buffer> <expr> <c-u> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Autocomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
