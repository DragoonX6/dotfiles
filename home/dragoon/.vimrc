filetype off

" set the runtime path to include Vundle and initialize
let baseRuntimePath = split(&runtimepath, ',')[0]

execute 'set rtp+=' . baseRuntimePath . '/bundle/Vundle.vim'

if isdirectory(expand(baseRuntimePath . '/bundle/Vundle.vim'))
	call vundle#begin(baseRuntimePath . '/bundle/')
	Plugin 'VundleVim/Vundle.vim'
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
	Plugin 'terryma/vim-multiple-cursors'
	Plugin 'idanarye/vim-dutyl'
	Plugin 'xolox/vim-misc'
	Plugin 'xolox/vim-lua-ftplugin'
	call vundle#end()
endif

filetype plugin indent on

runtime defaults.vim

if !has("win32")
	set term=xterm-256color
endif

" fuck backup files, undo files are enough
set nobackup
if has('persistent_undo')
	set undofile
	let myUndoDir = expand(baseRuntimePath . '/undo')
	call system('mkdir ' . myUndoDir)
	let &undodir = myUndoDir
endif

" Force encoding to UTF-8
set encoding=utf8

" GUI stuffs
" vim line
set colorcolumn=80
highlight ColorColumn ctermbg=Grey guibg=DarkGrey

" fancy colors
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
autocmd BufWritePre * if(index(['diff', 'markdown'], &ft)) < 0 | :call TrimWhitespace()

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

if !empty(glob(expand(baseRuntimePath . "/bundle/vim-airline")))
	call airline#add_statusline_func('WindowNumber')
	call airline#add_inactive_statusline_func('WindowNumber')
endif
" End GUI stuffs

" Generic keybinds
map <F3> :noh<CR>

" >not an editor command
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qa! qa!
cnoreabbrev Wqa wqa
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa

" Win32 tool paths
if has("win32")
	" Git
	let g:fugitive_git_executable = 'C:\PROGRA~1\Git\bin\git.exe'
	let g:ag_prg = 'D:\Programming\Utils\ag.exe --vimgrep'
	let g:tagbar_ctags_bin = 'D:\Programming\msys64\mingw64\bin\ctags.exe'
endif

" Cpp
let g:ycm_server_keep_logfiles = 0
let g:ycm_server_log_level = 'debug'
let g:ycm_confirm_extra_conf = 0

if has("win32")
	let g:ycm_use_clangd = 1
	let g:ycm_clangd_uses_ycmd_caching = 0

	" Use dotnet omnisharp instead
	let g:ycm_roslyn_binary_path= 'D:\Programming\msys64\home\Dragoon\omnisharp-roslyn\bin\Release\OmniSharp.Http.Driver\net6.0\OmniSharp.exe'
else
	" Use dotnet omnisharp instead
	" let g:ycm_roslyn_binary_path= expand(baseRuntimePath . '/../Projects/C#/omnisharp-roslyn/bin/Release/OmniSharp.Http.Driver/net6.0/OmniSharp')
endif

map <F2> :YcmCompleter GoTo<CR>

" cpp syntax hilight
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

" C++ indentation settings
set cinoptions=N-s,i-s,=0,b1,(0,W4,g0,t0,p0,j1

set tabstop=4 shiftwidth=4 noexpandtab

map <F4> :e %:p:s,.hpp$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,<CR>
map <F5> :e %:p:s,_impl.hpp$,.X123X,:s,.hpp$,_impl.hpp,:s,.X123X$,.hpp,<CR>

" D settings
let g:dutyl_stdImportPaths = ['/usr/include/dlang/dmd']
let g:dutyl_neverAddClosingParen = 1
let g:dutyl_dontHandleFormat = 1
let g:dutyl_dontHandleIndent = 1

" Snippets
let g:UltiSnipsSnippetDirectories=[baseRuntimePath . '/UltiSnips']

let g:lua_complete_dynamic = 0
