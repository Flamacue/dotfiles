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

" Rust
let g:rustfmt_autosave = 1

" Go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods= 1
let g:go_fmt_command = "goimports"

autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)

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
