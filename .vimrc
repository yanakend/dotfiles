"--------------------------------------------------------------------------------
" home
if $VIMHOME == ""
	if has('win32') || has ('win64')
		let $VIMHOME = $VIM."/vimfiles"
	else
		let $VIMHOME = $HOME."/.vim"
	endif
endif

"--------------------------------------------------------------------------------
" plugin
set nocp
if has('vim_starting')
	set runtimepath+=$VIMHOME/bundle/neobundle.vim
endif
call neobundle#rc(expand($VIMHOME.'/bundle/'))

" originalrepos on github
" 自動でリポジトリと同期するプラグイン
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
      \	'build': {
      \	  'cygwin': 'make -f make_cygwin.mak',
      \	  'mac':	'make -f make_mac.mak',
      \	  'unix':	'make -f make_unix.mak',
      \	},
      \ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle "Shougo/neosnippet"
NeoBundle "Shougo/neosnippet-snippets"
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neomru.vim', {
    \ 'depends' : 'Shougo/unite.vim'
    \ }
NeoBundle "h1mesuke/unite-outline"
"NeoBundle 'Shougo/vimshell'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'fuenor/qfixhowm'
NeoBundle 'vim-scripts/EnhCommentify.vim'
NeoBundle 'vim-scripts/savevers.vim'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'acustodioo/vim-enter-indent'
"NeoBundle 'vim-scripts/gtags.vim'
NeoBundle '5t111111/alt-gtags.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'vim-scripts/Align'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'gregsexton/gitv'
NeoBundle 'vim-scripts/SQLUtilities'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'vim-scripts/PreserveNoEOL'
NeoBundle 'gist:yanakend/7113121', { 'script_type' : 'plugin' }
NeoBundle 'nathanaelkane/vim-indent-guides.git'
NeoBundle 'thinca/vim-localrc'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Townk/vim-autoclose'

filetype plugin indent on
NeoBundleCheck

"--------------------------------------
" Get running OS
function! GetRunningOS()
  if has("win32")
    return "win"
  endif
  if has("unix")
    if has('gui_macvim')
      return "macvim"
    else
      return "linux"
    endif
  endif
endfunction
let os=GetRunningOS()

"----------------------------------------
" settings
set nocompatible					" viとの互換性を取らない
set t_Co=256						" 256色に
" カラースキーム設定
colorscheme desert
hi SpecialKey    ctermfg=darkgreen

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set guioptions=mr
set nonumber						" 行数表示
set hlsearch						" 索文字列を色づけ
set ignorecase						" 文字小文字を判別しない
set incsearch						" インクリメンタルサーチ
set nowrapscan						" 検索をファイルの末尾まで検索したら、ファイルの先頭へループする
set noterse							" ファイルの端まで検索してしまったときのメッセージが表示しない
set smartcase						" でも大文字小文字が混ざって入力されたら区別する
set tabstop=4						" 4タブ
set shiftwidth=4					" 4タブ
set expandtab						  " タブを空白に
set nowrap							" 折り返さない
set cmdheight=1						" コマンドラインの高さ(GUI使用時)
set ignorecase
set smartcase
set showcmd							" 入力中のコマンドをステータスに表示する
set laststatus=2					" ステータスラインを常に表示
set statusline=%n\:%F%=\ \|%Y\|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r<%l\|%c\|%L>
set autoindent
set cindent
set ambiwidth=double				" □や○の文字があってもカーソル位置がずれないようにする
set whichwrap=b,s,[,],<,>			" カーソルキーで行末／行頭の移動可能に設定
set title							" タイトルをウインドウ枠に表示する
set virtualedit=block				"ブロック選択時にフリーカーソルモード
set hidden							"バッファを切替えてもundoの効力を失わない
set backup
set writebackup
set backupdir=$VIMHOME/backup
set directory=$VIMHOME/swap
set imsearch=0
set iminsert=0
set formatoptions-=ro
set linespace=4
set diffopt=filler,vertical,foldcolumn:0
set fileformats=unix,dos,mac
set nofoldenable
"let php_folding=1

" Don't redraw while macro executing.
set lazyredraw
if os=="macvim"
  " macvimではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
  set iskeyword=@,48-57,_,128-167,224-235
  set macmeta
	let $PATH='/usr/local/Cellar/php55/5.5.7/bin:/usr/local/bin:/usr/local/bin:/usr/local/sbin:'.$PATH
endif
syntax on
set backupskip=/tmp/*,/private/tmp/*
set shortmess+=A " 警告を無効にする

"----------------------------------------
" map
if os=="win" || os=="macvim"
	nnoremap <silent> <C-[> :noh<CR>
else
	nnoremap <silent> <C-[><C-[> :noh<CR>
endif
nnoremap <silent> h zv<Left>
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> l zv<Right>

" windo diffthis
" diffoff!
" diff diff更新
nnoremap <silent> <Up> [c
nnoremap <silent> <Down> ]c
nnoremap <silent> <Left> dp
nnoremap <silent> <Right> do

nnoremap <silent> <C-j> :call NextDiff()<CR>
nnoremap <silent> <C-k> :call Prevdiff()<CR>
nnoremap <silent> <C-l> dp
nnoremap <silent> <C-h> do
function! NextDiff()
  if &diff
    silent normal! ]c
  else
    silent normal! <C-j>
  endif
endfunction
function! Prevdiff()
  if &diff
    silent normal! [c
  else
    silent normal! <C-k>
  endif
endfunction

" set imd
if os=="linux"
	nnoremap y "ay
	vnoremap y "ay
	nnoremap Y "ay$
	vnoremap Y "ay$
	nnoremap p "agp
	vnoremap p "agp
	nnoremap P "agP
	vnoremap P "agP
	vnoremap x "ax
	inoremap <C-v> <C-R>a
	cnoremap <C-v> <C-R>a
else
	nnoremap y "+y
	vnoremap y "+y
	nnoremap Y "+y$
	vnoremap Y "+y$
	nnoremap p "+gp
	vnoremap p "+gp
	nnoremap P "+gP
	vnoremap P "+gP
	vnoremap x "+x
	inoremap <C-v> <C-R>+
	cnoremap <C-v> <C-R>+
endif

nnoremap ZZ <Nop>
nnoremap <silent><Space>w  :write<CR>
nnoremap <silent><Space>vi :e $VIMHOME/../.vimrc<CR>

vnoremap <silent> / y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

cnoremap <C-a>	  <Home>
cnoremap <C-f>	  <Right>
cnoremap <C-b>	  <Left>
cnoremap <C-d>	  <Delete>
cnoremap <C-k>	  <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
cnoremap <C-w>	  <Home>\<<End>\><Left><Left>
cnoremap <C-c>	  <End>\C

" <TAB>: indent.
vnoremap <TAB>	>
" <S-TAB>: unindent.
vnoremap <S-TAB>  <

" Indent
vnoremap > >gv
vnoremap < <gv
			
" Insert mode keymappings:
" <C-d>: delete char.
inoremap <C-d>	<Del>
" <C-t>: insert tab.
inoremap <C-t>  <C-v><TAB>

" 選択した文字列を置換
vnoremap s "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>

" Like gv, but select the last changed text.
nnoremap gc  `[v`]
" Auto escape / and ? in search command.
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'

"----------------------------------------
" command
autocmd FileType html setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/
autocmd FileType objc setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType objcpp setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
autocmd FileType html setlocal tabstop=2 shiftwidth=2
autocmd FileType html.php setlocal tabstop=2 shiftwidth=2
autocmd FileType smarty setlocal tabstop=2 shiftwidth=2
autocmd FileType css setlocal tabstop=2 shiftwidth=2
autocmd FileType vim setlocal tabstop=2 shiftwidth=2 expandtab
autocmd BufRead,BufNewFile *.blade.php setlocal tabstop=2 shiftwidth=2 expandtab
autocmd BufRead,BufNewFile *.csv set filetype=csv
autocmd BufRead,BufNewFile *.mm set filetype=objc
autocmd FileType vim,text setlocal textwidth=0

"----------------------------------------
" quickrun.vim
if !exists("g:quickrun_config")
  let g:quickrun_config={}
endif
let g:quickrun_config["_"] = {
      \ "runner/vimproc/updatetime" : 80,
      \ "outputter/buffer/split" : ":rightbelow 8sp",
      \ "outputter/error/error" : "quickfix",
      \ "outputter/error/success" : "buffer",
      \ "outputter" : "error",
      \ }
let $JS_CMD='node'
function! QuickTest(arg1)
	execute "e $HOME/.vim/test.".a:arg1
endfunction
command! -nargs=1 Quick call QuickTest(<f-args>)

"----------------------------------------
" qfixhowm.vim
let g:MyGrep_ExcludeReg = '[~#]$\|\.dll$\|\.exe$\|\.lnk$\|\.o$\|\.obj$\|\.pdf$\|\.xls$\|logs[/\\]\|cached[/\\]\|compiled[/\\]\|[/\\]\.svn[/\\]\|[/\\]\.git[/\\]'
" 検索ディレクトリはカレントディレクトリを基点にしない
let g:MyGrep_CurrentDirMode = 1
let g:QFix_CloseOnJump = 1
let g:QFix_HighSpeedPreview = 1
let g:qfixmemo_mapleader = '<Space>g'
let QFix_PreviewHeight = 20
let g:MyGrep_FilePattern = '*'
let g:MyGrep_RecursiveMode = 1
" メモファイルの保存先
if os=="win"
  let qfixmemo_dir = 'D:\dev\Dropbox\qfixmemo'
endif
if os=="macvim" || os=="linux"
  let qfixmemo_dir = '~/Dropbox/qfixmemo'
endif

" QFixGrepの検索時にカーソル位置の単語を拾う/拾わない
let MyGrep_DefaultSearchWord = 0
nnoremap <Space>gg :cd <C-r>=expand("%:p:h")<CR>
" Windowsからcygwin1.7以降のgrep.exeを使用する場合
" UTF-8の一部文字列が検索不可なのを修正します。
if os=="win"
  let MyGrep_cygwin17 = 1
  let mygrepprg = 'D:/dev/cygwin/bin/grep'
  let grepprg='D:/dev/cygwin/bin/grep\ -nH'
endif

"----------------------------------------
" savevers.vim
":VersDiff - :VersDiff + :VersDiff -c :Purge -a 0
set patchmode=.clean			" バックアップファイルの設定savevers.vimのためにパッチモードにします
let savevers_types = "*"		" カンマで区切られたバックアップを作成するファイル名です *.c,*.h,*.vim
let savevers_dirs = &backupdir	" バックアップファイルが書き込まれるディレクトリです
let versdiff_no_resize=1		" バックアップファイルとの比較でウィンドウのサイズを変更する場合は0
let savevers_max = 99

"----------------------------------------
" EnhancedCommentify.vim
nnoremap <Space>/ :call EnhancedCommentify('yes', 'comment')<CR>
vnoremap <Space>/ :call EnhancedCommentify('yes', 'comment')<CR>
nnoremap <Space>? :call EnhancedCommentify('no', 'decomment')<CR>
vnoremap <Space>? :call EnhancedCommentify('no', 'decomment')<CR>

""-------------------------------------------------------------------
" neocomplcache.git
" neocomplcacheを起動時に有効化する
let g:neocomplcache_enable_at_startup = 1
" 'smartcase'と同様に、大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1
" _区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1
" シンタックスをキャッシュするときの最小文字長を3
let g:neocomplcache_min_syntax_length = 3
" これをしないと候補選択時に Scratch ウィンドウが開いてしまう
set completeopt=menuone

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : '',
      \ 'vimshell': $HOME.'/.vimshell_hist',
      \ 'php'	  : $HOME . '/dotfiles/.vim/dict/php.dict',
      \ 'tpl'	  : $HOME . '/dotfiles/.vim/dict/php.dict',
      \ 'ctp'	  : $HOME . '/dotfiles/.vim/dict/php.dict',
      \ }

" Define keyword.
" smartyはhtmlと同じに
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
let g:neocomplcache_keyword_patterns['smarty'] = '</\?\%([[:alnum:]_:-]\+\s*\)\?\%(/\?>\)\?\|&amp;\h\%(\w*;\)\?\|\h[[:alnum:]_-]*="\%([^"]*"\?\)\?\|\h[[:alnum:]_:-]*'

" 関数を補完するための区切り文字パターン
if !exists('g:neocomplcache_delimiter_patterns')
  let g:neocomplcache_delimiter_patterns = {}
endif
let g:neocomplcache_delimiter_patterns['php'] = ['->', '::', '\']

" smartyはhtmlと同じに
if !exists('g:neocomplcache_next_keyword_patterns')
  let g:neocomplcache_next_keyword_patterns = {}
endif
let g:neocomplcache_next_keyword_patterns['smarty'] = '[[:alnum:]_:-]*>\|[^"]*"'

" オムニ補完
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType smarty setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

" 改行で補完ウィンドウを閉じる
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
" tabで補完候補の選択を行う
inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"
" C-h, BSで補完ウィンドウを確実に閉じる
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<BS>"
" C-yで補完候補の確定
inoremap <expr><C-y> neocomplcache#close_popup()
" C-eで補完のキャンセルし、ウィンドウを閉じる。ポップアップが開いていないときはEndキー
inoremap <expr><C-e> pumvisible() ? neocomplcache#cancel_popup() : "\<End>"
" C-gで補完を元に戻す
inoremap <expr><C-g> neocomplcache#undo_completion()
" vim標準のキーワード補完を置き換える
inoremap <expr><C-n> neocomplcache#manual_keyword_complete()

"------------------------------------
" neosnippet.vim
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"----------------------------------------
" unite.vim
" 入力モードで開始する
let g:unite_enable_start_insert = 1
let g:unite_enable_short_source_names = 1
let g:unite_split_rule = 'botright'
"let g:unite_source_file_mru_limit = 200
let g:neomru#file_mru_path=expand('~/.vim/.neomru_file')
let g:neomru#directory_mru_path=expand('~/.vim/.neomru_direcroty')

" バッファ一覧	-auto-resize
nnoremap <silent> <Space>b	:<C-u>Unite buffer -horizontal -direction=botright<CR>
" 最近使用したファイル一覧
nnoremap <silent> <Space>m	:<C-u>Unite file_mru -horizontal -direction=botright<CR>
" 関数一覧
nnoremap <silent> <Space>f :<C-u>Unite outline -horizontal -direction=botright<CR>
" unite.vim上でのキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " 単語単位からパス単位で削除するように変更
  inoremap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " ESCキーを押すと終了する
  imap <silent><buffer> <C-j> <Down>
  imap <silent><buffer> <C-k> <Up>
  nmap <silent><buffer> <C-[> <Plug>(unite_exit)
  nmap <silent><buffer> <ESC> <Plug>(unite_exit)
"  nunmap <silent><buffer> N
endfunction

"----------------------------------------
" vim-filer.vim
" K ディレクトリ作成
" i ファイル作成
" I 特定ディレクトリへ異動
" r リネーム
" dd 削除
" cc コピー
" <C-J> 履歴
let s:bundle = neobundle#get('vimfiler')
function! s:bundle.hooks.on_source(bundle)
  autocmd FileType vimfiler call s:vimfiler_my_settings()
  function! s:vimfiler_my_settings()
    nunmap <buffer> j
    nunmap <buffer> k
  	nmap <buffer> <Space><Space> <Plug>(vimfiler_toggle_mark_current_line)
    " ESCキーを押すと終了する
    nmap <silent><buffer> <C-[> q
    nmap <silent><buffer> <ESC> q
    " N は検索として、i を新規作成にする
    nunmap <buffer> N
    nmap <buffer> i <Plug>(vimfiler_new_file)
  endfunction
  " vimfilerをデフォルトのファイラにする
  let g:vimfiler_as_default_explorer = 1
  " セーフモード無効化
  let g:vimfiler_safe_mode_by_default = 0

  let g:vimfiler_draw_files_limit=1000
  " デフォルトでvim開く
  call vimfiler#set_execute_file('_', 'vim')
  " ココにvimfilerの設定とか記述する。
endfunction
nnoremap <silent><Space>e  :VimFilerBufferDir<cr>

"------------------------------------
" EnhCommentify.vim
function! EnhCommentifyCallback(ft)
	if a:ft == 'objc'
		let b:ECcommentOpen = '//'
		let b:ECcommentClose = ''
	endif
	if a:ft == 'objcpp'
		let b:ECcommentOpen = '//'
		let b:ECcommentClose = ''
	endif
	if a:ft == 'smarty'
		let b:ECcommentOpen = '\{* '
		let b:ECcommentMiddle = ''
		let b:ECcommentClose = ' *\}'
	endif
endfunction
let g:EnhCommentifyCallbackExists = 'Yes'

"------------------------------------
" vimdoc-ja.git
helptags $VIMHOME/doc
set helplang=ja,en

"------------------------------------
" gtags
nnoremap <Space>td :AltGtags<CR>
nnoremap <Space>tr :AltGtags -r<CR>
nnoremap <Space>ts :AltGtags -s<CR>
nnoremap <Space>tf :AltGtags -f<CR>
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>
nnoremap <C-q> :ccl<CR>

"------------------------------------
" 空白→タブ変換
set list
set listchars=tab:.\ 
"function! s:CleanSpace()
"  let cursor = getpos(".")
"  %s@^\v(%( {4})+)@\=repeat("\t", len(submatch(1))/4)@e
"  call setpos(".", cursor)
"  unlet cursor
"endfunction
"autocmd BufWritePre *.php call <SID>CleanSpace()

"------------------------------------
" vim-fugitive
let g:Gitv_DoNotMapCtrlKey = 0
nnoremap <silent> <Space>gb :Gblame<CR>
nnoremap <silent> <Space>gd :Gdiff<CR>zR<C-W>hgg]c
nnoremap <silent> <Space>gD :Gdiff HEAD<CR>zR<C-W>hgg]c
nnoremap <silent> <Space>gl :Gitv!<CR>
nnoremap <silent> <Space>gr :Gread<CR>
nnoremap <silent> <Space>gs :Gstatus<CR>
function! s:toggle_git_folding()
  if &filetype ==# 'git'
    setlocal foldenable!
  endif
endfunction
autocmd FileType fugitiveblame call s:fugitiveblame_my_settings()
function! s:fugitiveblame_my_settings()
  nnoremap <silent><buffer> <C-[> :close<CR>
endfunction
autocmd FileType gitcommit call s:gitcommit_my_settings()
function! s:gitcommit_my_settings()
  nnoremap <silent><buffer> <C-[> :close<CR>
endfunction
 
"------------------------------------
" gitv
autocmd FileType gitv call s:my_gitv_settings()
function! s:my_gitv_settings()
  " s:my_gitv_settings 内
  setlocal iskeyword+=/,-,.
  nnoremap <silent><buffer> <C-[> :close<CR>
  nnoremap <silent><buffer> C  :<C-u>Git checkout <C-r><C-w><CR>
  nnoremap <silent><buffer> Rb :<C-u>Git rebase <C-r>=GitvGetCurrentHash()<CR><Space>
  nnoremap <silent><buffer> Rv :<C-u>Git revert <C-r>=GitvGetCurrentHash()<CR><CR>
  nnoremap <silent><buffer> P  :<C-u>Git cherry-pick <C-r>=GitvGetCurrentHash()<CR><CR>
  nnoremap <silent><buffer> Rh :<C-u>Git reset --hard <C-r>=GitvGetCurrentHash()<CR>
	nnoremap <silent><buffer> t :<C-u>windo call <SID>toggle_git_folding()<CR>1<C-w>w
endfunction

" これは外に定義!
function! s:gitv_get_current_hash()
  return matchstr(getline('.'), '\[\zs.\{7\}\ze\]$')
endfunction

"------------------------------------
" ctrlp.vim
let g:ctrlp_clear_cache_on_exit = 0   " 終了時キャッシュをクリアしない
let g:ctrlp_mruf_max            = 500 " MRUの最大記録数

"------------------------------------
" syntastic.vim
let g:syntastic_ignore_files=['\.tpl$','\.m$']

"------------------------------------
" gundo.vim
nmap U :<C-u>GundoToggle<CR>

"------------------------------------
" lightline.vim
let g:lightline = {
        \ 'colorscheme': 'powerline',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction

"------------------------------------
" ctrlp.vim
let g:ctrlp_map = '<Space>p'
let g:ctrlp_regexp = 1
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|cache)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
  \ }

"------------------------------------
" vim-ref
let g:ref_phpmanual_path = $VIMHOME.'/doc/php-chunked-xhtml'
autocmd FileType ref call s:initialize_ref_viewer()
function! s:initialize_ref_viewer()
  nmap <buffer> b (ref-back)
  nmap <buffer> f (ref-forward)
  nnoremap <buffer> q c
  nnoremap <buffer> c
  setlocal nonumber
endfunction

"------------------------------------
" vim-shell
"let g:vimshell_prompt_expr = 'getcwd()."% "'
"let g:vimshell_prompt_pattern = '^\f\+% '

"------------------------------------
" PreserveNoEOL
let g:PreserveNoEOL = 1

"------------------------------------
" EasyMotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)
"map  / <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"------------------------------------
" clever-f.vim
let g:clever_f_smart_case = 1

