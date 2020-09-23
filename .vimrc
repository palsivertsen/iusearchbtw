call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'palsivertsen/molokai' | Plug 'palsivertsen/vim-color'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' | Plug 'ervandew/supertab' | Plug 'palsivertsen/vim-go-snippets' " GO111MODULE=on go get golang.org/x/tools/gopls@latest
Plug 'osyo-manga/vim-brightest'
Plug 'dense-analysis/ale'
call plug#end()

set nu rnu
set noexpandtab tabstop=2 shiftwidth=2
set hlsearch incsearch
set autochdir
set ignorecase
set wildmenu
set scrolloff=999
set termguicolors

" Undercurl control chars for gnome terminal
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

" vim-go
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_addtags_transform = "camelcase"
let g:go_auto_type_info = 1
" highlighing
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

" keybindings
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" Ale
let g:ale_proto_protoc_gen_lint_options = "-I=/usr/local/include"
" Completion
let g:UltiSnipsExpandTrigger = "<nul>" " terminal sends NUL on ctrl+space
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" vim-brightest
let g:brightest#highlight = {
\   "group" : "Visual"
\}

" ctrlp
let g:ctrlp_show_hidden = 1

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Colorscheme
colorscheme molokai
