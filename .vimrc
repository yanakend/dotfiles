"--------------------------------------------------------------------------------
" plugin
set nocp
if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#rc(expand('~/.vim/bundle/'))
filetype plugin on

" originalrepos on github
" 自動でリポジトリと同期するプラグイン
NeoBundle 'Shougo/neobundle.vim.git'
NeoBundle 'Shougo/vimproc.git', {
      \	'build': {
      \	  'cygwin': 'make -f make_cygwin.mak',
      \	  'mac':	'make -f make_mac.mak',
      \	  'unix':	'make -f make_unix.mak',
      \	},
      \ }
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/vimshell.git'
"NeoBundle 'Shougo/neosnippet.git'

NeoBundle 'thinca/vim-quickrun.git'
NeoBundle 'vim-jp/vimdoc-ja.git'
NeoBundle 'fuenor/qfixhowm.git'
NeoBundle 'vim-scripts/EnhCommentify.vim.git'
NeoBundle 'vim-scripts/savevers.vim.git'
NeoBundle 'vim-scripts/sudo.vim.git'
NeoBundle 'acustodioo/vim-enter-indent.git'
NeoBundle 'vim-scripts/gtags.vim.git'
NeoBundle 'scrooloose/syntastic.git'
NeoBundle 'vim-scripts/Align.git'
NeoBundle 'othree/eregex.vim.git'
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'Lokaltog/vim-easymotion.git'
NeoBundle 'gregsexton/gitv.git'
NeoBundle 'vim-scripts/SQLUtilities.git'
NeoBundle 'tpope/vim-fugitive.git'
NeoBundle 'kien/ctrlp.vim.git'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Shougo/vimfiler'
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
set noexpandtab						  " タブを空白に
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
set backupdir=~/.vim/backup
set directory=~/.vim/swap
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
	let $PATH='/usr/local/bin/usr/local/bin:/usr/local/sbin:'.$PATH
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

" search
" *での検索時は次候補ではなくカーソル下結果から動かないように
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *N
nnoremap <silent> # #N

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
nnoremap <silent><Space>vi :e ~/dotfiles/.vimrc<CR>

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
nnoremap > >>
nnoremap < <<
vnoremap > >gv
vnoremap < <gv
			
" Insert mode keymappings:
" <C-d>: delete char.
inoremap <C-d>	<Del>
" <C-t>: insert tab.
inoremap <C-t>  <C-v><TAB>

"ヤンクした文字列とカーソル位置の単語を置換する vim bible p123
"cy カーソル位置移行の文字列とヤンクした単語を置換
"ciyテキストオブジェクト的にカーソルが単語内のどこにあってもヤンクした文字列と置換
"必要ならn.で繰り返し実行
nnoremap <silent> cy ce<C-r>a<ESC>:let@/=@1<CR>:noh<CR>
nnoremap <silent> ciy ciw<C-r>a<ESC>:let@/=@1<CR>:noh<CR>

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

"--------------------------------------------------------------------------------
" netrw.vim
"nnoremap <silent><Space>e :Exp<cr>
"autocmd FileType netrw call s:retrw_my_settings()
"function! s:retrw_my_settings() " ESCキーを押すと終了する
"  nmap <silent><buffer> <C-[> <C-o>
"  nmap <silent><buffer> <ESC> <C-o>
"  nmap <silent><buffer> q	   <C-o>
"  nmap <silent><buffer> l	   <cr>
"  nmap <silent><buffer> h	   -
"endfunction

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
":VersDiff - :VersDiff + :VersDiff -c
set patchmode=.clean			" バックアップファイルの設定savevers.vimのためにパッチモードにします
let savevers_types = "*"		" カンマで区切られたバックアップを作成するファイル名です *.c,*.h,*.vim
let savevers_dirs = &backupdir	" バックアップファイルが書き込まれるディレクトリです
let versdiff_no_resize=1		" バックアップファイルとの比較でウィンドウのサイズを変更する場合は0
let savevers_max = 99			"

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
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" smartyはhtmlと同じに
let g:neocomplcache_keyword_patterns['smarty'] = '</\?\%([[:alnum:]_:-]\+\s*\)\?\%(/\?>\)\?\|&amp;\h\%(\w*;\)\?\|\h[[:alnum:]_-]*="\%([^"]*"\?\)\?\|\h[[:alnum:]_:-]*'

" 関数を補完するための区切り文字パターン
if !exists('g:neocomplcache_delimiter_patterns')
  let g:neocomplcache_delimiter_patterns = {}
endif
let g:neocomplcache_delimiter_patterns['php'] = ['->', '::', '\']

if !exists('g:neocomplcache_next_keyword_patterns')
  let g:neocomplcache_next_keyword_patterns = {}
endif
" smartyはhtmlと同じに
let g:neocomplcache_next_keyword_patterns['smarty'] = '[[:alnum:]_:-]*>\|[^"]*"'

" オムニ補完
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType smarty setlocal omnifunc=htmlcomplete#CompleteTags
autocmd BufRead,BufNewFile *.csv set filetype=csv
"autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
" textwidth設定上書き
autocmd FileType vim,text setlocal textwidth=0

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

"----------------------------------------
" unite.vim
" 入力モードで開始する
" バッファ一覧	-auto-resize
nnoremap <silent> <Space>b	:<C-u>Unite buffer -horizontal -direction=botright<CR>
" 最近使用したファイル一覧
nnoremap <silent> <Space>m	:<C-u>Unite file_mru -direction=botright<CR>
" 関数一覧
nnoremap <silent> <Space>f :<C-u>Unite get_function -direction=botright<CR>
" unite.vim上でのキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " 単語単位からパス単位で削除するように変更
  inoremap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " ESCキーを押すと終了する
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
" Cc コピー
" Cp 貼り付け
" <C-J> 履歴
let s:bundle = neobundle#get('vimfiler')
function! s:bundle.hooks.on_source(bundle)
  autocmd FileType vimfiler call s:vimfiler_my_settings()
  function! s:vimfiler_my_settings()
    " ESCキーを押すと終了する
    nmap <silent><buffer> <C-[> q
    nmap <silent><buffer> <ESC> q
    nunmap <buffer> j
    nunmap <buffer> k
    " N は検索として、i を新規作成にする
    nunmap <buffer> N
    nmap <buffer> i <Plug>(vimfiler_new_file)
  endfunction
  " vimfilerをデフォルトのファイラにする
  let g:vimfiler_as_default_explorer = 1
  " セーフモード無効化
  let g:vimfiler_safe_mode_by_default = 0
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
helptags ~/.vim/doc
set helplang=ja,en

"------------------------------------
" gtags
" カーソル以下の定義元を探す
nnoremap <Space>td :Gtags <C-r><C-w><CR><C-w><C-w>
" カーソル以下の使用箇所を探す
nnoremap <Space>tr :Gtags -r <C-r><C-w><CR><C-w><C-w>
" Grep 準備
nnoremap <Space>tg :Gtags -g 
" このファイルの関数一覧
nnoremap <Space>tf :Gtags -f %<CR>
" 検索結果Windowを閉じる
nnoremap <C-q> :ccl<CR>

"------------------------------------
" 空白→タブ変換
"set list
"set listchars=tab:.\ 
function! s:CleanSpace()
  let cursor = getpos(".")
  %s@^\v(%( {4})+)@\=repeat("\t", len(submatch(1))/4)@e
  call setpos(".", cursor)
  unlet cursor
endfunction
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
"  D diff
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
" eregex.vim :M/ で起動
let g:eregex_default_enable = 0

"------------------------------------
" JDoc
" Auto JDoc Commands
autocmd FileType javascript nnoremap <silent> <Space>c :call JsJDoc()<CR>
autocmd FileType php nnoremap <silent> <Space>c :call PhpJDoc()<CR>

" Insert JDoc Comment
" param summary: Summary of the function
" param args: list of arguments' name
function! AddJDocComment(summary, args)
  let c = indent(".") / &tabstop
  let top = a:firstline - 1 
  let l = a:firstline - 1 
  let s = ''
  while len(s) < (c) 
    let s = s . "\t"
  endwhile

  call append(l, s . '/**')
  let l+=1
  call append(l, s . ' * ' . a:summary)
  let l+=1
  call append(l, s . ' * ' . a:summary)
  let l+=1

  for arg in a:args
    let arg_name = matchstr(arg, '.*')
    call append(l, s . ' * @param  array ' . arg_name . ' ')
    let l+=1
    if arg_name == '$params'
      call append(l, s . ' * @param  id    ' . arg_name . '.user_id ユーザーID')
      let l+=1
    endif
  endfor

  call append(l, s . ' * @return void ' . a:summary)
  let l+=1

  call append(l, s . ' */')

  call cursor(top+2, 80) 
  call feedkeys('A', 'n')
endfunction

" Insert JDoc Comment in Js source code
function! JsJDoc()
  let args = split(matchstr(getline('.'), 'function(\zs.*\ze)'),' *, *')
  call AddJDocComment('', args)
endfunction

" Insert JDoc Comment in PHP source code
function! PhpJDoc()
  let args = split(matchstr(getline('.'), 'function [^(]*(\zs.*\ze)'),' *, *')
  call AddJDocComment('', args)
endfunction

" コメントからバリデートへ置換
function! Com2Val()
  let line = substitute(getline('.'), '.*@\(\w\+\)\(\W\+\)\([0-9a-zA-Z,]\+\)\(\W\+\)\(\w\+\)\(\W\+\)\(\w\+\).*', "'".'\7'."'"." => "."'".'\3'."',", '')
  call setline('.', line)
endfunction

" ymlから配列形式へ置換
function! Yml2Array()
  let line = substitute(getline('.'), '\([0-9A-Za-z_-]\+\)[ ]*:[ '."'".'"]*\([0-9A-Za-z_-]\+\)['."'".'"]*', "'".'\1'."'"." => "."'".'\2'."',", '')
  call setline('.', line)
endfunction

"------------------------------------
" syntastic.vim
let g:syntastic_ignore_files=['\.tpl$']

"------------------------------------
" gundo.vim
nmap U :<C-u>GundoToggle<CR>

"------------------------------------
" tab
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill #'
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
" Tab jump
nmap    t [Tag]
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" tc 新しいタブを一番右に作る
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>
" tn 次のタブ
map <silent> [Tag]n :tabnext<CR>
" tp 前のタブ
map <silent> [Tag]p :tabprevious<CR>

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
