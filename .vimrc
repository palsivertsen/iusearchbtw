call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'palsivertsen/molokai'
"Plug 'Erichain/vim-monokai-pro'
Plug 'palsivertsen/vim-color'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' | Plug 'ervandew/supertab' | Plug 'palsivertsen/vim-go-snippets' " GO111MODULE=on go get golang.org/x/tools/gopls@latest
Plug 'dense-analysis/ale'
Plug 'unblevable/quick-scope'
call plug#end()

set nu rnu
set noexpandtab tabstop=2 shiftwidth=2
set hlsearch incsearch
set autochdir
set ignorecase
set wildmenu
set scrolloff=999
set nowrap
set listchars=eol:$,space:·,tab:>-

" Undercurl control chars for gnome terminal
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

" Truecolor
set termguicolors
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"

" folding
set foldmethod=syntax
set foldlevelstart=99
set foldnestmax=2

" Colorscheme
"colorscheme vim-color
"colorscheme monokai_pro
colorscheme molokai

" quick scope
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline


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
autocmd Filetype go set spell

" keybindings
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
nnoremap <c-_> :nohlsearch<cr>

" Ale
let g:ale_proto_protoc_gen_lint_options = "-I=/usr/local/include -I=$(git rev-parse --show-toplevel)"
let g:ale_linters = {'go': ['gofmt', 'golint', 'gopls', 'govet', 'golangci-lint']}
let ale_go_golangci_lint_options = ""
" Completion
let g:UltiSnipsExpandTrigger = "<nul>" " terminal sends NUL on ctrl+space
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" ctrlp
let g:ctrlp_show_hidden = 1

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Git
" Spellcheck commit messages
autocmd Filetype gitcommit set spell

" Protobuf
autocmd Filetype proto set expandtab tabstop=2 shiftwidth=2
