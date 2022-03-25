call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' | Plug 'ervandew/supertab' | Plug 'palsivertsen/vim-go-snippets'
Plug 'dense-analysis/ale'
Plug 'unblevable/quick-scope'
Plug 'palsivertsen/vim-cterm'
Plug 'palsivertsen/lowercase-dockerfile'
Plug 'preservim/tagbar'
call plug#end()

set nu rnu
set noexpandtab tabstop=2 shiftwidth=2
set hlsearch incsearch
set autochdir
set ignorecase
set wildmenu
set scrolloff=999
set listchars=eol:$,space:·,tab:>-

let g:mapleader=" "
nnoremap <Leader>h :lbefore<CR>
nnoremap <Leader>j :lbelow<CR>
nnoremap <Leader>k :labove<CR>
nnoremap <Leader>l :lafter<CR>

" TODO extract to plugin
if $TERM == "xterm-kitty"
	let &t_Cs = "\e[4:3m"
	let &t_Ce = "\e[4:0m"
	let &t_8u = "\e[58;2;%lu;%lu;%lum"
	let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
	let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
endif

" Spelling
set spelllang=en_us,nb
set spellfile=~/.vim/spell/custom.utf-8.add
set spell

" Wrapping
set breakindent
set breakindentopt=sbr
set showbreak=↳

" folding
set foldmethod=syntax
set foldlevelstart=99
set foldnestmax=2

""""""""""
" Colors "
""""""""""
" Use terminal colors
set notermguicolors
" Colorscheme
colorscheme vim-cterm
" Airline theme
let g:airline_theme='molokai'
" Quick scope
highlight QuickScopePrimary cterm=undercurl ctermul=green
highlight QuickScopeSecondary cterm=undercurl ctermul=yellow
" Other colors
highlight GitGutterAdd        ctermfg=green ctermbg=NONE cterm=NONE ctermul=NONE
highlight GitGutterChange     ctermfg=yellow ctermbg=NONE cterm=NONE ctermul=NONE
highlight GitGutterDelete     ctermfg=red ctermbg=NONE cterm=NONE ctermul=NONE
highlight QuickFixLine        ctermfg=yellow ctermbg=NONE cterm=NONE ctermul=NONE
highlight goSameids           ctermbg=darkgrey

" vim-go
let g:go_fmt_fail_silently = 1
let g:go_addtags_transform = "camelcase"
let g:go_auto_type_info = 1
let g:go_template_autocreate = 0
let g:go_auto_sameids = 1
" highlighing
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1
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
let g:ale_go_golangci_lint_options = ""
let g:ale_go_golangci_lint_package = 1

" Completion
let g:UltiSnipsExpandTrigger = "<nul>" " terminal sends NUL on ctrl+space
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
" Highlighting
highlight! link ALEWarningSign Warning

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
