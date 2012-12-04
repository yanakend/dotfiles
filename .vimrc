"--------------------------------------
" Get running OS
function! GetRunningOS()
	if has("win32")
		return "win"
	endif
	if has("unix")
		if system('uname')=~'Darwin'
			return "mac"
		else
			return "linux"
		endif
	endif
endfunction
let os=GetRunningOS()

"----------------------------------------
" ユーザーランタイムパス設定
"Windows, unixでのruntimepathの違いを吸収するためのもの。 
"$MY_VIMRUNTIMEはユーザーランタイムディレクトリを示す。 
":echo $MY_VIMRUNTIMEで実際のパスを確認できます。 
if isdirectory($HOME . '/.vim') 
  let $MY_VIMRUNTIME = $HOME.'/.vim'
endif 
set runtimepath+=$MY_VIMRUNTIME

"----------------------------------------
" settings
set nocompatible                    " viとの互換性を取らない
syntax on
set t_Co=256                        " 256色に
" カラースキーム設定
if os=="win"
    colorscheme user_color
endif
if os=="mac" || os=="linux"
    colorscheme desert
endif

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set guioptions=mr

set nonumber                        " 行数表示
set hlsearch                        " 索文字列を色づけ
set ignorecase                      " 文字小文字を判別しない
set incsearch                       " インクリメンタルサーチ
set nowrapscan                      " 検索をファイルの末尾まで検索したら、ファイルの先頭へループする
set noterse                         " ファイルの端まで検索してしまったときのメッセージが表示しない
set smartcase                       " でも大文字小文字が混ざって入力されたら区別する
set tabstop=4                       " 4タブ
set shiftwidth=4                    " 4タブ
set noexpandtab                       " タブを空白に
set nowrap                          " 折り返さない
set cmdheight=1                     " コマンドラインの高さ(GUI使用時)
set ignorecase
set smartcase
set showcmd                         " 入力中のコマンドをステータスに表示する
set laststatus=2                    " ステータスラインを常に表示
set statusline=%n\:%F%=\ \|%Y\|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r<%l\|%c\|%L>
set autoindent
set cindent
"set shellslash                      " Windowsでディレクトリパスの区切り文字表示に / を使えるようにする
set ambiwidth=double                " □や○の文字があってもカーソル位置がずれないようにする
set whichwrap=b,s,[,],<,>           " カーソルキーで行末／行頭の移動可能に設定
set title                           " タイトルをウインドウ枠に表示する
set virtualedit=block               "ブロック選択時にフリーカーソルモード
set hidden                          "バッファを切替えてもundoの効力を失わない

set backup
set writebackup
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set imsearch=0
set iminsert=0
set formatoptions-=ro
set linespace=4
set diffopt=filler,vertical,foldcolumn:0
"set undofile
"set undodir=~/.vim/undo
set fileformats=unix,dos,mac

"----------------------------------------
" map
if os=="win" || os=="mac"
	nnoremap <silent> <C-[> :noh<CR>
endif 
nnoremap <silent> h zv<Left>
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> l zv<Right>

"sort
"bufdo diffthis
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> <C-j> :call NextDiff()<CR>
nnoremap <silent> <C-k> :call Prevdiff()<CR>
nnoremap <silent> <C-h> dp
nnoremap <silent> <C-l> do
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

"inoremap <ESC> <ESC>:set iminsert=0<CR>  " ESCでIMEを確実にOFF
"set imd
if os=="mac" || os=="linux"
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
    "nnoremap <silent> <Space>y :.w !pbcopy<CR><CR>
    "vnoremap <silent> <Space>y :w !pbcopy<CR><CR>
    "nnoremap <silent> <Space>p :r !pbpaste<CR>
    "vnoremap <silent> <Space>p :r !pbpaste<CR>
    "nnoremap <Space>g :REGrep
endif
if os=="win"
    nnoremap y "+y
    vnoremap y "+y
    nnoremap Y "+y$
    vnoremap Y "+y$
    nnoremap p "+gp
    vnoremap p "+gp
    nnoremap P "+gP
    vnoremap P "+gP
    nnoremap x "_x
    vnoremap x "+x
    nnoremap X "_X
    vnoremap X "+X
    inoremap <C-v> <C-R>+
    cnoremap <C-v> <C-R>+
    nnoremap <Space>g :silent !"C:\Program Files\Yokka\NoEditor\Grep.exe.lnk"<CR>
endif

nnoremap ZZ <Nop>
nnoremap <silent><Space>e  :VimFilerBufferDir<cr>
nnoremap <silent><Space>d  :Kwbd<CR>
nnoremap <silent><Space>w  :write<CR>
nnoremap <silent><Space>vi :e ~/.vimrc<CR>
nnoremap <silent><Space>r  :<C-u>Unite ref/phpmanual<CR>
if os=="win"
    nnoremap <Space>f  :e D:\dev\Dropbox\free_memo.txt<CR>
    nnoremap <Space>td :!start "C:\Program files\TortoiseSVN\bin\TortoiseProc.exe" /command:diff /path:"%" /notempfile /closeonend<CR>
    nnoremap <Space>tl :!start "C:\Program files\TortoiseSVN\bin\TortoiseProc.exe" /command:log  /path:"%" /notempfile /closeonend<CR>
endif
if os=="mac" || os=="linux"
    nnoremap <Space>f  :e /Users/yanagikenji/Dropbox/free_memo.txt<CR>
endif

"nnoremap <silent> <Space>co :ContinuousNumber <C-a><CR>
"vnoremap <silent> <Space>co :ContinuousNumber <C-a><CR>
vnoremap <silent> /  :<C-u>call MySetSearch('""vgvy')<CR>:let &hlsearch=&hlsearch<CR>
nnoremap <C-g>    `.

cnoremap <C-a>    <Home>
cnoremap <C-f>    <Right>
cnoremap <C-b>    <Left>
cnoremap <C-d>    <Delete>
cnoremap <C-w>    <Home>\<<End>\><Left><Left>
cnoremap <C-c>    <End>\C
cnoremap <C-k>    <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>

vnoremap <        <gv
vnoremap >        >gv

"ヤンクした文字列とカーソル位置の単語を置換する vim bible p123
"cy カーソル位置移行の文字列とヤンクした単語を置換
"ciyテキストオブジェクト的にカーソルが単語内のどこにあってもヤンクした文字列と置換
"必要ならn.で繰り返し実行
nnoremap <silent> cy ce<C-r>a<ESC>:let@/=@1<CR>:noh<CR>
"vnoremap <silent> cy c<C-r>a<ESC>:let@/=@1<CR>:noh<CR>
nnoremap <silent> ciy ciw<C-r>a<ESC>:let@/=@1<CR>:noh<CR>

"----------------------------------------
" command
command!                 Kwbd       let kwbd_bn= bufnr("%")|enew|exe "bd ".kwbd_bn|unlet kwbd_bn 
command!                 Cp932      edit ++enc=cp932
command!                 Eucjp      edit ++enc=euc-jp
command!                 Iso2022jp  edit ++enc=iso-2022-jp
command!                 UTF8       edit ++enc=utf-8
command!                 Jis        Iso2022jp
command!                 Sjis       Cp932
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor
autocmd FileType html setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/
autocmd FileType objc setlocal tabstop=2 | setlocal shiftwidth=2 | setlocal noexpandtab
autocmd FileType objcpp setlocal tabstop=2 | setlocal shiftwidth=2 | setlocal noexpandtab
autocmd FileType javascript setlocal tabstop=2 | setlocal shiftwidth=2 | setlocal noexpandtab

if os=="mac" || os=="linux"
    autocmd BufNewFile,BufRead *.html setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.html.php setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.css setlocal tabstop=2 shiftwidth=2
endif
autocmd FileType html setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/
 
"----------------------------------------
" function

"----------------------------------------
" 検索ワードをセットする。
" 何か追加パラメータが設定されていたら、単語単位検索に。
function! MySetSearch(cmd, ...)
    let saved_reg = @"
    if a:cmd != ''
      silent exec 'normal! '.a:cmd
    endif
    let pattern = escape(@", '\\/.*$^~[]')
    let pattern = substitute(pattern, '\n$', '', '')
    if a:0 > 0
      let pattern = '\<'.pattern.'\>'
    endif
    let @/ = pattern
    let @" = saved_reg
endfunction 

"----------------------------------------
" pathogen.vim
filetype off 
call pathogen#runtime_append_all_bundles() 
call pathogen#helptags() 
set helpfile=$VIMRUNTIME/doc/help.txt 
filetype plugin on

"----------------------------------------
" quickrun.vim
"let g:quickrun_no_default_key_mappings = 0
"silent! nnoremap <Space>r <Plug>(quickrun)
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

"----------------------------------------
" qfixhowm.vim
let g:MyGrep_ExcludeReg = '[~#]$\|\.dll$\|\.exe$\|\.lnk$\|\.o$\|\.obj$\|\.pdf$\|\.xls$\|logs[/\\]\|cached[/\\]\|compiled[/\\]\|[/\\]\.svn[/\\]\|[/\\]\.git[/\\]'
" 検索ディレクトリはカレントディレクトリを基点にする
let g:MyGrep_CurrentDirMode = 1
let g:QFix_CloseOnJump = 1
let g:QFix_HighSpeedPreview = 1
let g:qfixmemo_mapleader = '<Space>g'
" QFixGrepの検索時にカーソル位置の単語を拾う/拾わない
let MyGrep_DefaultSearchWord = 0
nnoremap <Space>gg :cd <C-r>=expand("%:p:h")<CR>
" Windowsからcygwin1.7以降のgrep.exeを使用する場合
" UTF-8の一部文字列が検索不可なのを修正します。
let MyGrep_cygwin17 = 1
if os=="win"
    let mygrepprg = 'D:/dev/cygwin/bin/grep'
    let grepprg='D:/dev/cygwin/bin/grep\ -nH'
endif

"----------------------------------------
" netrw.vim
"nnoremap <silent><Space>e :Exp<cr>
"autocmd FileType netrw call s:retrw_my_settings()
"function! s:retrw_my_settings() " ESCキーを押すと終了する
"  nmap <silent><buffer> <C-[> <C-o>
"  nmap <silent><buffer> <ESC> <C-o>
"  nmap <silent><buffer> q     <C-o>
"  nmap <silent><buffer> l     <cr>
"  nmap <silent><buffer> h     -
"endfunction

"----------------------------------------
" savevers.vim
set patchmode=.clean            " バックアップファイルの設定savevers.vimのためにパッチモードにします
let savevers_types = "*"        " カンマで区切られたバックアップを作成するファイル名です *.c,*.h,*.vim
let savevers_dirs = &backupdir  " バックアップファイルが書き込まれるディレクトリです
let versdiff_no_resize=1        " バックアップファイルとの比較でウィンドウのサイズを変更する場合は0
let savevers_max = 99           " 
":VersDiff -
":VersDiff +
":VersDiff -c

"----------------------------------------
" EnhancedCommentify.vim
nnoremap <Space>/ :call EnhancedCommentify('yes', 'comment')<CR>
vnoremap <Space>/ :call EnhancedCommentify('yes', 'comment')<CR>
nnoremap <Space>? :call EnhancedCommentify('no', 'decomment')<CR>
vnoremap <Space>? :call EnhancedCommentify('no', 'decomment')<CR>

"----------------------------------------
" neocomplecache.vim
" 補完ウィンドウの設定
set completeopt=menuone
" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1
" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1
" _(アンダースコア)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_camel_case_completion  =  1
" ポップアップメニューで表示される候補の数
let g:neocomplcache_max_list = 20
" シンタックスをキャッシュするときの最小文字長
let g:neocomplcache_min_syntax_length = 3
" ディクショナリ定義
if os=="win"
	let g:neocomplcache_dictionary_filetype_lists = {
		\ 'default' : '',
		\ 'php' : $HOME . '/.vim/dict/php.dict',
		\ 'ctp' : $HOME . '/.vim/dict/php.dict'
		\ }
endif
if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" スニペットを展開する。スニペットが関係しないところでは行末まで削除
imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
smap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
" 前回行われた補完をキャンセルします
inoremap <expr><C-g> neocomplcache#undo_completion()
" 補完候補のなかから、共通する部分を補完します
inoremap <expr><C-l> neocomplcache#complete_common_string()
" 改行で補完ウィンドウを閉じる
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
"tabで補完候補の選択を行う
inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"
" <C-h>や<BS>を押したときに確実にポップアップを削除します
inoremap <expr><C-h> neocomplcache#smart_close_popup() . "\<C-h>"
" 現在選択している候補を確定します
inoremap <expr><C-y> neocomplcache#close_popup()
" 現在選択している候補をキャンセルし、ポップアップを閉じます
inoremap <expr><C-e> neocomplcache#cancel_popup()
" ディクショナリ定義
if os=="win"
	let g:neocomplcache_dictionary_filetype_lists = {
		\ 'default' : '',
		\ 'php' : $HOME . '/.vim/dict/php.dict',
		\ 'ctp' : $HOME . '/.vim/dict/php.dict'
		\ }
endif
"補完するためのキーワードパターンを指定
if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
endif
"日本語を補完候補として取得しないようにする
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

"----------------------------------------
" ref.vim
if os=="mac" || os=="linux"
    let g:ref_phpmanual_path = '/Users/yanagikenji/.vim/php_doc/php-chunked-xhtml/'
endif
if os=="win"
    let g:ref_phpmanual_path = 'C:\Users\yanagikenji\.vim\php_doc\php-chunked-xhtml\'
    let g:ref_phpmanual_encoding = 'Shift-JIS'
    let $PATH = $PATH . ';C:\Program Files\Lynx for Win32'
endif
"let g:ref_phpmanual_cmd = 'w3m -dump %s'
autocmd FileType ref-phpmanual call s:initialize_ref_viewer()
function! s:initialize_ref_viewer()
    nmap <silent><buffer> <ESC> :bd<CR>
    nmap <silent><buffer> q     :bd<CR>
    nmap <silent><buffer> <C-[> :bd<CR>
    setlocal nonumber
endfunction

"----------------------------------------
" unite.vim
" 入力モードで開始する
"let g:unite_enable_start_insert=1
"let g:unite_source_file_mru_time_format
let g:vimfiler_as_default_explorer = 1
nnoremap <silent> <Space>r  :<C-u>Unite ref/phpmanual<CR>
" バッファ一覧  -auto-resize
nnoremap <silent> <Space>b  :<C-u>Unite buffer -horizontal -direction=botright<CR>
" ファイル一覧
nnoremap <silent> <Space>uf :<C-u>UniteWithBufferDir -buffer-name=files -direction=botright file<CR>
" レジスタ一覧
nnoremap <silent> <Space>ur :<C-u>Unite -buffer-name=register -direction=botright register<CR>
" 最近使用したファイル一覧
nnoremap <silent> <Space>m  :<C-u>Unite file_mru -direction=botright<CR>
" 常用セット
nnoremap <silent> <Space>uu :<C-u>Unite buffer file_mru -direction=botright<CR>
" 全部乗せ
nnoremap <silent> <Space>ua :<C-u>UniteWithBufferDir -buffer-name=files -direction=botright buffer file_mru bookmark file<CR>
" unite.vim上でのキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " 単語単位からパス単位で削除するように変更
  inoremap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " ESCキーを押すと終了する
  nmap <silent><buffer> <C-[> <Plug>(unite_exit)
  nmap <silent><buffer> <ESC> <Plug>(unite_exit)
endfunction

"----------------------------------------
" vim-filer.vim
autocmd FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings() " ESCキーを押すと終了する
  nmap <silent><buffer> <C-[> q
  nmap <silent><buffer> <ESC> q
  nunmap <buffer> j
  nunmap <buffer> k
  nunmap <buffer> N
  nmap <buffer> i <Plug>(vimfiler_new_file)
  hi vimfilerCurrentDirectory gui=UNDERLINE guifg=#0000ff guibg=NONE
endfunction
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
call vimfiler#set_execute_file('plist,pch,vim,php,ctp,txt,jax,css,h,m,html,c,storyboard,strings,cpp,js,patch,sql,tpl,csv,log,pl,sh,ini,jmx,coffee,yml,cs,rb', 'vim')

"----------------------------------------
" git-vim.vim
nnoremap <silent><Space>id :GitDiff<cr>
nnoremap <silent><Space>iD :GitDiff —cache<cr>
nnoremap <silent><Space>is :GitStatus<cr>
nnoremap <silent><Space>il :GitLog<cr>
nnoremap <silent><Space>ia :GitAdd<cr>
nnoremap <silent><Space>iA :GitAdd<cr>
nnoremap <silent><Space>ic :GitCommit<cr>

"----------------------------------------
" vimshell setting
let g:vimshell_interactive_update_time = 10
let g:vimshell_prompt = $USERNAME."% "
" vimshell map
nnoremap <silent> vs :VimShell<CR>
"nnoremap <silent> vsc :VimShellCreate<CR>
nnoremap <silent> vp :VimShellPop<CR>

"----------------------------------------
" vim-powerline
if os=="mac" || os=="linux"
	set guifont=Osaka-Powerline:h10
endif
let g:Powerline_symbols='fancy'
call Pl#Hi#Allocate({
  \ 'black'          : 16,
  \ 'white'          : 231,
  \
  \ 'darkestgreen'   : 22,
  \ 'darkgreen'      : 28,
  \
  \ 'darkestcyan'    : 21,
  \ 'mediumcyan'     : 117,
  \
  \ 'darkestblue'    : 24,
  \ 'darkblue'       : 31,
  \
  \ 'darkestred'     : 52,
  \ 'darkred'        : 88,
  \ 'mediumred'      : 124,
  \ 'brightred'      : 160,
  \ 'brightestred'   : 196,
  \
  \ 'darkestyellow'  : 59,
  \ 'darkyellow'     : 100,
  \ 'darkestpurple'  : 57,
  \ 'mediumpurple'   : 98,
  \ 'brightpurple'   : 189,
  \
  \ 'brightorange'   : 208,
  \ 'brightestorange': 214,
  \
  \ 'gray0'          : 233,
  \ 'gray1'          : 235,
  \ 'gray2'          : 236,
  \ 'gray3'          : 239,
  \ 'gray4'          : 240,
  \ 'gray5'          : 241,
  \ 'gray6'          : 244,
  \ 'gray7'          : 245,
  \ 'gray8'          : 247,
  \ 'gray9'          : 250,
  \ 'gray10'         : 252,
  \ })
" 'n': normal mode
" 'i': insert mode
" 'v': visual mode
" 'r': replace mode
" 'N': not active
let g:Powerline#Colorschemes#my#colorscheme = Pl#Colorscheme#Init([
  \ Pl#Hi#Segments(['SPLIT'], {
    \ 'n': ['white', 'gray2'],
    \ 'N': ['gray0', 'gray0'],
    \ }),
  \
  \ Pl#Hi#Segments(['mode_indicator'], {
    \ 'i': ['darkestgreen', 'white', ['bold']],
    \ 'n': ['darkestcyan', 'white', ['bold']],
    \ 'v': ['darkestpurple', 'white', ['bold']],
    \ 'r': ['mediumred', 'white', ['bold']],
    \ 's': ['white', 'gray5', ['bold']],
    \ }),
  \
  \ Pl#Hi#Segments(['fileinfo', 'filename'], {
    \ 'i': ['white', 'darkestgreen', ['bold']],
    \ 'n': ['white', 'darkestcyan', ['bold']],
    \ 'v': ['white', 'darkestpurple', ['bold']],
    \ 'r': ['white', 'mediumred', ['bold']],
    \ 'N': ['gray0', 'gray2', ['bold']],
    \ }),
  \
  \ Pl#Hi#Segments(['branch', 'scrollpercent', 'raw', 'filesize'], {
    \ 'n': ['gray2', 'gray7'],
    \ 'N': ['gray0', 'gray2'],
    \ }),
  \
  \ Pl#Hi#Segments(['fileinfo.filepath', 'status'], {
    \ 'n': ['gray10'],
    \ 'N': ['gray5'],
    \ }),
  \
  \ Pl#Hi#Segments(['static_str'], {
    \ 'n': ['white', 'gray4'],
    \ 'N': ['gray1', 'gray1'],
    \ }),
  \
  \ Pl#Hi#Segments(['fileinfo.flags'], {
    \ 'n': ['white'],
    \ 'N': ['gray4'],
    \ }),
  \
  \ Pl#Hi#Segments(['currenttag', 'fileformat', 'fileencoding', 'pwd', 'filetype', 'rvm:string', 'rvm:statusline', 'virtualenv:statusline', 'charcode', 'currhigroup'], {
    \ 'n': ['gray9', 'gray4'],
    \ }),
  \
  \ Pl#Hi#Segments(['lineinfo'], {
    \ 'n': ['gray2', 'gray10'],
    \ 'N': ['gray2', 'gray4'],
    \ }),
  \
  \ Pl#Hi#Segments(['errors'], {
    \ 'n': ['white', 'gray2'],
    \ }),
  \
  \ Pl#Hi#Segments(['lineinfo.line.tot'], {
    \ 'n': ['gray2'],
    \ 'N': ['gray2'],
    \ }),
  \
  \ Pl#Hi#Segments(['paste_indicator', 'ws_marker'], {
    \ 'n': ['white', 'brightred', ['bold']],
    \ }),
  \
  \ Pl#Hi#Segments(['gundo:static_str.name', 'command_t:static_str.name'], {
    \ 'n': ['white', 'mediumred', ['bold']],
    \ 'N': ['brightred', 'darkestred', ['bold']],
    \ }),
  \
  \ Pl#Hi#Segments(['gundo:static_str.buffer', 'command_t:raw.line'], {
    \ 'n': ['white', 'darkred'],
    \ 'N': ['brightred', 'darkestred'],
    \ }),
  \
  \ Pl#Hi#Segments(['gundo:SPLIT', 'command_t:SPLIT'], {
    \ 'n': ['white', 'darkred'],
    \ 'N': ['white', 'darkestred'],
    \ }),
  \
  \ Pl#Hi#Segments(['ctrlp:focus', 'ctrlp:byfname'], {
    \ 'n': ['brightpurple', 'darkestpurple'],
    \ }),
  \
  \ Pl#Hi#Segments(['ctrlp:prev', 'ctrlp:next', 'ctrlp:pwd'], {
    \ 'n': ['white', 'mediumpurple'],
    \ }),
  \
  \ Pl#Hi#Segments(['ctrlp:item'], {
    \ 'n': ['darkestpurple', 'white', ['bold']],
    \ }),
  \
  \ Pl#Hi#Segments(['ctrlp:marked'], {
    \ 'n': ['brightestred', 'darkestpurple', ['bold']],
    \ }),
  \
  \ Pl#Hi#Segments(['ctrlp:count'], {
    \ 'n': ['darkestpurple', 'white'],
    \ }),
  \
  \ Pl#Hi#Segments(['ctrlp:SPLIT'], {
    \ 'n': ['white', 'darkestpurple'],
    \ }),
  \ ])
let g:Powerline_colorscheme='my'
let g:Powerline_mode_n = 'NORMAL'

