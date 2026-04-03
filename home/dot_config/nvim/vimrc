let s:dein_dir = expand('~/.vim/dein')

" reset augroup
augroup LocalAutoCmd
	autocmd!
augroup END

" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
	if !isdirectory(s:dein_repo_dir)
		execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
	endif
	execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	" プラグインリストを収めた TOML ファイル
	" ~/.vim/rc/dein.toml,deinlazy.tomlを用意する
	let g:rc_dir    = expand('~/.vim/rc')
	let s:toml      = g:rc_dir . '/dein.toml'
	let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

	" TOML を読み込み、キャッシュしておく
	call dein#load_toml(s:toml,      {'lazy': 0})
	call dein#load_toml(s:lazy_toml, {'lazy': 1})

	" 設定終了
	call dein#end()
	call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
	call dein#install()
endif

function! s:dein_list() abort
    echomsg '[dein] #: not sourced, X: not installed'
    for pair in items(dein#get())
        echomsg (!isdirectory(pair[1].path) ? 'X' : pair[1].sourced ? ' ' : '#') pair[0]
    endfor
endfunction
command! DeinList call s:dein_list()
command! DeinCacheClean call dein#clear_state()
command! DeinUpdate call dein#update()
function! s:dein_update_log() abort
    echomsg '[dein] updates log'
    echomsg dein#get_updates_log()
endfunction
command! DeinUpdateLog call s:dein_update_log()

filetype plugin indent on
syntax on

"""""
set t_Co=256

set wildmenu
set showcmd
set shiftwidth=4
set autoindent
set smartindent
set smarttab
set tabstop=4
set expandtab
set nobackup
set autoread
set noswapfile
set nowrap
set backspace=indent,eol,start
set textwidth=0
set tags=~/.tags

" incremant option.
set nf=hex

" increment
nnoremap ++ <C-a>
nnoremap -- <C-x>

" set IME Off
set iminsert=0
set imsearch=0
set imdisable

" disable matchparen
let g:loaded_matchparen = 1

""" ----- filetype settings
augroup coding
    autocmd!
    autocmd FileType c,cpp,perl,rb,php,ctp,python set cindent
    autocmd FileType php set ft=php.html
    autocmd FileType smarty set ft=smarty.html
augroup END

" undo setting
if has('persistent_undo')
    set undodir=~/.vim/undo
    set undofile
endif

""" ----- misc
" escape
inoremap <silent> <Esc> <Esc>
inoremap <silent> <C-[> <Esc>

"Prefix-key
nnoremap [Prefix] <nop>
nmap , [Prefix]

" shift + move selection
imap <S-down> <ESC>v
imap <S-up> <ESC>v<up>
imap <S-left> <ESC>v
imap <S-right> <ESC><right>v
vnoremap <S-down> <down>
vnoremap <S-up> <up>
vnoremap <S-left> <left>
vnoremap <S-right> <right>

" move option
nnoremap <silent> g. `.
nnoremap <silent> g0 `.0
nnoremap <silent> gm ``

" auto paren (visual mode)
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

" yank to line end
nmap Y y$<ESC>

" reload .vimrc
nnoremap [Prefix]vr  :<C-u>source $MYVIMRC<Return>
command! -nargs=0 ReloadSetting :<C-u>source $MYVIMRC<Return>
nnoremap [Prefix]vv  :<C-u>e $MYVIMRC<Return>

""" unite prefix key

" key-remap (require unite)
nnoremap <silent> [Prefix]ub :<C-u>Unite buffer<CR>
nnoremap <silent> [Prefix]us :<C-u>Unite snippet<CR>
nnoremap <silent> [Prefix]uy :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [Prefix]uR :<C-u>vsplit<CR><C-w><C-w>:<C-u>Unite neomru/file<CR>
nnoremap <silent> [Prefix]ur :<C-u>Unite neomru/file -default-action=tabopen<CR>
nnoremap <silent> [Prefix]uH :<C-u>Unite qfixhowm<CR>
nnoremap <silent> [Prefix]uh :<C-u>Unite qfixhowm -default-action=tabopen<CR>
nnoremap <silent> [Prefix]uG :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> [Prefix]ug :<C-u>UniteResume search-buffer<CR>
nnoremap <silent> [Prefix]ut :<C-u>Unite tab<CR>
nnoremap <silent> [Prefix]fn :<C-u>Unite outline<CR>

" Open Scratch
command! -nargs=0 ScratchOpen :tabnew<CR>e ~/.scratch.howm

" temp extention file
command! -nargs=1 -complete=filetype Temp tabe ~/.scratch.<args>

command! -nargs=0 Recent :Unite neomru/file -default-action=tabopen
command! -nargs=0 Bookmark :Unite bookmark -default-action=tabopen

""" ----- gui settings
if has('gui_running')
	set guioptions-=T " hide toolbar
	set guioptions-=e " gui環境で tablineを使う
	set antialias
	set visualbell t_vb= " no beep

	set guifont=Cica:h16
    "set guifontwide=01フロップデザイン:h10

	" special chars (GUI only)
	""set lcs=tab:>.,trail:_,extends:\
	set nolist

	" reset IME (Insert mode)
	"au BufNewFile,BufRead * set iminsert=0
endif

set clipboard+=unnamed
""" EOF
