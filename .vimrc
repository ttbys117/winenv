" win / linux (gtk) compatible .vimrc
"
set nocompatible              " Don't be compatible with vi

" leader key assignment.
let g:mapleader=","             " change the leader to be a comma vs slash

" ==========================================================
" configuration for Windows.
" ==========================================================
if has("win32")
	"
	" skip Windows settings.
	let g:skip_loading_mswin=1

	function ShellDefault()
		let &shell = g:defaultshell
		let &shellcmdflag = g:defaultshellcmdflag
		let &shellslash = g:defaultshellslash
	endfunction

	function ShellGit()
		let &shell = g:gitshell
		let &shellcmdflag = g:gitshellcmdflag
		let &shellslash = g:gitshellslash
	endfunction

	function ShellWin()
		let &shell = g:winshell
		let &shellcmdflag = g:winshellcmdflag
		let &shellslash = g:winshellslash
	endfunction

	" Change default runtimepath.
	set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after

	set fileformats=unix,dos
	set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,default,latin

	" shell definition
	let g:defaultshell = "bash"
	let g:defaultshellcmdflag = "--login -c"
	let g:defaultshellslash = 1 	" true

	let g:gitshell = "C:\\Program Files\\Git\\git-cmd.exe"
	let g:gitshellcmdflag = ""
	let g:gitshellslash = 1 	" true

	let g:winshell = "cmd.exe"
	let g:winshellcmdflag = "/c"
	let g:winshellslash = 0 	" false
	" ----------------------------------------------------------------------------
	"set shell=cmd.exe
	"set noshellslash

	call ShellDefault()

	" IME control
	setglobal iminsert=0
	setglobal imsearch=0

elseif has("unix")
 	"set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,/usr/share/vim-scripts,$VIM/vimfiles/after,$HOME/.vim/after
	"set shell=bash
	"set shellcmdflag = "-c"
	"
endif

" ==========================================================
"  scripts should be read as utf-8
" ==========================================================
set encoding=utf-8
scriptencoding utf-8

" ==========================================================
" Plugins
" ==========================================================
call plug#begin('~/.vim/plugged')

Plug 'SirVer/ultisnips'
Plug 'altercation/vim-colors-solarized'
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'jalvesaq/Nvim-R'
Plug 'nikvdp/ejs-syntax'
" Plug 'tpope/vim-fugitive'
" Plug 'w0rp/ale'
" Plug 'davidhalter/jedi-vim'
" Plug 'pangloss/vim-javascript'
" Plug 'vim-latex/vim-latex'

call plug#end()

" ==========================================================
" Config plugins: General
" ==========================================================
" Coc
" if hidden is not set, TextEdit might fail.
set hidden
" " Some servers have issues with backup files, see #649
" set nobackup
" set nowritebackup
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <s-space> to trigger completion.
inoremap <silent><expr> <s-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" zip
let g:zip_unzipcmd = "gunzip"
let g:zip_zipcmd = "gzip"

" Gundo
nnoremap <F5> :GundoToggle<CR>

" NERDTree
let g:NERDTreeShowBookmarks = 1
" Open NerdTree
map <leader>n :NERDTreeToggle<CR>


" ==========================================================
" Config plugins: Language specific
" ==========================================================

" Python
if has("python3")
	" jedi
	" ** jedi is not filetype plugin.
	let g:jedi#completions_command = "<C-;>"
	let g:jedi#documentation_command = "K"
	let g:jedi#popup_on_dot = 0
	let g:jedi#usages_command = "<leader>jn"
endif


" latex-suite
let g:tex_flavor='latex'


" NVim-R
let g:R_args = ['--encoding=utf-8']
if has("win32")
	let g:R_path = "C:\\Program Files\\R\\R-3.6.3\\bin\\x64"
endif

"
"" Ale
noremap <leader>f :ALEFix<CR>

" let g:ale_linters = {'java': ['checkstyle']}

" let g:ale_fixers = {
" \   'javascript': ['eslint', 'prettier'],
" \   'html': ['eslint'],
" \   'awk': ['gawk'],
" \   'markdown': ['prettier', 'write-good'],
" \   'python': ['autopep8','flake8'],
" \   'xml': ['xmllint'],
" \   'yaml': ['prettier'],
" \   'css': ['prettier'],
" \   'json': ['fixjson', 'jq'],
" \   'go': ['gofmt'],
" \}


" ==========================================================
" Basic Settings
" ==========================================================
:syntax on                     " syntax highlighing
:filetype on                   " try to detect filetypes
:filetype plugin indent on     " enable loading indent file for filetype
set number                    " Display line numbers
set numberwidth=5             "
set title                     " show title in console title bar
set wildmenu                  " Menu completion in command mode on <Tab>
set wildmode=full             " <Tab> cycles between all matching choices.
set showcmd		      " display incomplete commands
set tags=~/.tags,.tags	      " standard C library tags

" backup
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history

" Status Line
"set stl=%t%m%r%y(%{&ff}:%{&enc})\ [%03b:%02B]\ [%03c,%03l]\ %P
set stl=%t%m%r%y(%{&ff}:%{&enc})\ [%03b:%02B]\ [%03c,%03l]\ %P\ \ \ \[%{strftime('%Y\ %b\ %d\ %X')}\]

""" Moving Around/Editing
set cursorline              " have a line indicate the cursor location
set nocursorcolumn
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=2             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
" set showmatch               " Briefly jump to a paren once it's balanced
set nowrap                  " don't wrap text
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
set smartindent             " use smart indent if there is no indent file
" set matchpairs+=<:>         " show matching <> (html mainly) as well
" set foldmethod=marker

"""" Messages, Info, Status
set laststatus=2            " allways show status line
" don't bell or blink
set noerrorbells
set novb
set vb t_vb=

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex
"
set ch=2		    " Make command line two lines high

"
"
" color setting in console
if has("win32")
	colorscheme solarized
	set background=light
elseif has("unix")
	colorscheme torte
	set background=dark
endif


" Copy and Paste from clipboard
noremap <leader>p "+p
vnoremap <C-Y> "+y
" for pasting the clipboard contents to command line, use '<C-R><C-R>*'
" sequence.
" '*' is the register name of clipboard.

" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" open/close the quickfix window
nmap <leader>co :copen<CR>
nmap <leader>cc :cclose<CR>

" open quickfix result in new tab.
set switchbuf+=usetab,newtab

" clear quickfix window.
nmap <leader>com! :call setqflist([])<CR>


"
" create index with '^N.N. ' format line.
"
" all levels
nnoremap <leader>toc :vimgrep /\v^(\d+<bar>\u)\.(\d+\.*)*\ / %:p <bar> copen<CR>
" 2 levels
nnoremap <leader>to2 :vimgrep /\v^(\d+<bar>\u)\.(\d+\.*){0,1}\ / %:p <bar> copen<CR>
" top level
nnoremap <leader>to1 :vimgrep /\v^(\d+<bar>\u)\.\ / %:p <bar> copen<CR>

"
" quotate selected lines.
vnoremap <leader>q :s/^/\>\ /<CR>

"
" urldecode a line.
nnoremap <LocalLeader>enc :call <SNR>1_urlEn()<CR>
function! s:urlEn()
	python3 << EOF
import urllib.parse
import vim
vim.current.line = urllib.parse.unquote(vim.current.line)
EOF
endfunction
nnoremap <LocalLeader>u :call <SNR>1_urlDe()<CR>
function! s:urlDe()
	python3 << EOF
import urllib.parse
import vim
vim.current.line = urllib.parse.quote(vim.current.line)
EOF
endfunction

set grepprg=grep\ -nH\ $*\ /dev/null

" ===========================================================
" Return to last saved position.
" ============================================================
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif


" ===========================================================
" FileType templates
" ============================================================
augroup templates
	autocmd!
	autocmd BufReadPre *.awk	call s:ChkTmpl(expand("%:e"))
	autocmd BufReadPre *.html 	call s:ChkTmpl(expand("%:e"))
	autocmd BufReadPre *.xhtml	call s:ChkTmpl(expand("%:e"))
	autocmd BufReadPre *.mom	call s:ChkTmpl(expand("%:e"))
	autocmd BufReadPre *.md 	call s:ChkTmpl(expand("%:e"))
	autocmd BufReadPre *.plain	call s:ChkTmpl(expand("%:e"))
	autocmd BufReadPre *.py		call s:ChkTmpl(expand("%:e"))
	autocmd BufReadPre *.sh		call s:ChkTmpl(expand("%:e"))
	autocmd BufReadPre *.txt	call s:ChkTmpl(expand("%:e"))

	autocmd BufNewFile *.awk	call s:ReadTmpl(expand("%:e"))
	autocmd BufNewFile *.html 	call s:ReadTmpl(expand("%:e"))
	autocmd BufNewFile *.xhtml	call s:ReadTmpl(expand("%:e"))
	autocmd BufNewFile *.mom	call s:ReadTmpl(expand("%:e"))
	autocmd BufNewFile *.md 	call s:ReadTmpl(expand("%:e"))
	autocmd BufNewFile *.plain	call s:ReadTmpl(expand("%:e"))
	autocmd BufNewFile *.py		call s:ReadTmpl(expand("%:e"))
	autocmd BufNewFile *.sh		call s:ReadTmpl(expand("%:e"))
	autocmd BufNewFile *.txt	call s:ReadTmpl(expand("%:e"))

	function! s:ChkTmpl(ext)
		:if getfsize(expand("%")) == 0
			:let tmpl = "~/vimfiles/templates/source_template." . a:ext
			:execute ':0r ' . '~/.vim/templates/source_template.' . a:ext
		:endif
	endfunction

	function! s:ReadTmpl(ext)
		:let tmpl = "~/vimfiles/templates/source_template." . a:ext
		:execute ':0r ' . '~/.vim/templates/source_template.' . a:ext
	endfunction
augroup END

" ==================
" Shell variables are overwritten at times.
" ==================

if has('win32')
	map <Leader>ln :call ShellDefault()<CR>
	map <Leader>gt :call ShellGit()<CR>
	map <Leader>wn :call ShellWin()<CR>
endif
