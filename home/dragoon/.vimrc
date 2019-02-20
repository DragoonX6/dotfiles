filetype off

" set the runtime path to include Vundle and initialize
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin('$HOME/.vim/bundle')
Plugin 'VundleVim/Vundle.vim'
" Plugin 'oblitum/YouCompleteMe'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'godlygeek/tabular'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'kien/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'rking/ag.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'tikhomirov/vim-glsl'
Plugin 'SirVer/ultisnips'
Plugin 'romainl/vim-qf'
Plugin 'Konfekt/vim-alias'
call vundle#end()

filetype plugin indent on

let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

source $VIMRUNTIME/defaults.vim

set nobackup		" fuck backup files, undo files are enough
if has('persistent_undo')
	set undofile
	let myUndoDir = expand(vimDir . '/undo')
	call system('mkdir ' . myUndoDir)
	let &undodir = myUndoDir
endif

" GUI stuffs
" vim line
set colorcolumn=80
highlight ColorColumn ctermbg=Grey guibg=DarkGrey

try
	colorscheme desertEx
	" Make caret small and set color to white
	set guicursor=n-v-c:ver25-Cursor/lCursor,ve:ver25-Cursor/lCursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
	highlight Cursor ctermfg=16 ctermbg=16 guifg=black guibg=white
catch /^Vim\%((\a\+)\)\=:E185/
	" ignored
endtry

" Remove toolbar
if has("gui_running")
	set guioptions-=T
	set guioptions-=m
endif

" Unix line endings
set ff=unix
set fileformats=unix,dos

if has("win32")
	set guifont=DejaVu_Sans_Mono_for_Powerline:h10:cANSI:qDRAFT
else
	set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
endif

" Visualize whitepsace
set listchars=tab:→→,trail:●,nbsp:○
set list

" Clean whitespace on save
fun! TrimWhitespace()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfun
autocmd BufWritePre * if(index(['diff'], &ft)) < 0 | :call TrimWhitespace()

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_extensions = ['tabline', 'ycm']
let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#ycm#error_symbol = 'E:'
let g:airline#extensions#ycm#warning_symbol = 'W:'

function! WindowNumber(...)
	let builder = a:1
	let context = a:2
	call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
	return 0
endfunction

if !empty(glob("$HOME/.vim/bundle/vim-airline"))
	call airline#add_statusline_func('WindowNumber')
	call airline#add_inactive_statusline_func('WindowNumber')
endif
" End GUI stuffs

" Cpp
let g:ycm_server_keep_logfiles = 0
let g:ycm_server_log_level = 'debug'
let g:ycm_confirm_extra_conf = 0

" cpp syntax hilight
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

" C++ indentation settings
set cinoptions=N-s,i-s,=0,b1,(0,W4,g0,t0,p0,j1

set tabstop=4 shiftwidth=4 noexpandtab
set makeprg ="python3 ./waf build"

map <F4> :e %:p:s,.hpp$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,<CR>
map <F5> :e %:p:s,_impl.hpp$,.X123X,:s,.hpp$,_impl.hpp,:s,.X123X$,.hpp,<CR>
map <F2> :YcmCompleter GoTo<CR>
map <F3> :noh<CR>