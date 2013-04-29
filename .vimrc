" http://py.vaults.ca/~x/python_and_vim.html

set nocp
set backspace=2
set autoindent
set nocin
set ruler
set nowrap
set hidden
set showmatch
set matchtime=3
set t_Co=256
set wrapscan
set incsearch
set ignorecase
set hlsearch
set smartcase
set updatecount=50
set modeline modelines=5 nu spr

set iskeyword-=_
set isfname+=_

set pastetoggle=<F2>

"highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" abbr epoch <C-R>=strftime('%s')<CR>

call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

autocmd BufRead,BufNewFile *.html set filetype=php

filetype indent on
filetype plugin on

set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType scss set omnifunc=csscomplete#CompleteCSS

let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1
let php_folding=0

nnoremap <silent> <Space> @=(foldclosed('.')!=-1?'za':'l')<CR>
vnoremap <Space> zf

autocmd FileType php set makeprg=php\ -l\ %
autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l

set wildmenu
set wildmode=list:longest,full

function! MyTabOrComplete()
	let col = col('.')-1
		if !col || getline('.')[col-1] !~ '\k'
		return "\<tab>"
	else
		return "\<C-N>"
	endif
endfunction
inoremap <Tab> <C-R>=MyTabOrComplete()<CR>

set suffixesadd=.php,.class.php,.inc.php
set includeexpr=substitute(v:fname,'-$','','g')

syntax on

colorscheme herald
set background=dark

cnoremap w!! w !sudo dd of=%

set ffs=unix,dos,mac

set tabstop=2 softtabstop=2 shiftwidth=2

" make keypad work in vim with iTerm on OS X!
map <Esc>Oq 1
map <Esc>Or 2
map <Esc>Os 3
map <Esc>Ot 4
map <Esc>Ou 5
map <Esc>Ov 6
map <Esc>Ow 7
map <Esc>Ox 8
map <Esc>Oy 9
map <Esc>Op 0
map <Esc>On .
map <Esc>OQ /
map <Esc>OR *
map <kPlus> +
map <Esc>OS -
map! <Esc>Oq 1
map! <Esc>Or 2
map! <Esc>Os 3
map! <Esc>Ot 4
map! <Esc>Ou 5
map! <Esc>Ov 6
map! <Esc>Ow 7
map! <Esc>Ox 8
map! <Esc>Oy 9
map! <Esc>Op 0
map! <Esc>On .
map! <Esc>OQ /
map! <Esc>OR *
map! <kPlus> +
map! <Esc>OS -
