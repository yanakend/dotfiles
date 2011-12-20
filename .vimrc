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
set t_Co=256                        "256色に
"カラースキーム設定
if has('win32')
    colorscheme user_color
endif
if has('unix')
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
set expandtab                       " タブを空白に
set nowrap                          " 折り返さない
set cmdheight=1                     " コマンドラインの高さ(GUI使用時)
set ignorecase
set smartcase
set showcmd                         " 入力中のコマンドをステータスに表示する
set laststatus=2                    " ステータスラインを常に表示
set statusline=%n\:%F%=\ \|%Y\|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r<%l/%L:%p%%>
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
"zi do dp [c ]c diffoff!

"----------------------------------------
" map
nnoremap <silent> <C-[> :noh<CR>
nnoremap <silent> h zv<Left>
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> l zv<Right>

nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz

nnoremap <silent> <C-j> ]c
nnoremap <silent> <C-k> [c
nnoremap <silent> <C-l> do
nnoremap <silent> <C-h> dp

if has('unix')
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
    nnoremap <Space>g  :REGrep<CR>
endif
if has('win32')
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
    nnoremap <Space>g  :silent !"C:\Program Files\Yokka\NoEditor\Grep.exe.lnk"<CR>
endif

nnoremap ZZ <Nop>

nnoremap <Space>e  :VimFiler<CR>
nnoremap <Space>d  :Kwbd<CR>
nnoremap <Space>w  :write<CR>
nnoremap <Space>v  :e ~/.vimrc<CR>
"nnoremap <Space>c  :cd %:h<CR>
if has('win32')
    nnoremap <Space>f  :e C:\dev\Dropbox\Dropbox\free_memo.txt<CR>
    nnoremap <Space>td :!start "C:\Program files\TortoiseSVN\bin\TortoiseProc.exe" /command:diff /path:"%" /notempfile /closeonend<CR>
    nnoremap <Space>tl :!start "C:\Program files\TortoiseSVN\bin\TortoiseProc.exe" /command:log  /path:"%" /notempfile /closeonend<CR>
endif
if has('unix')
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
vnoremap <silent> cy c<C-r>a<ESC>:let@/=@1<CR>:noh<CR>
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
if has('unix')
    autocmd BufNewFile,BufRead *.html.php setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.css setlocal tabstop=2 shiftwidth=2
endif

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
" savevers.vim
set patchmode=.clean            " バックアップファイルの設定" savevers.vimのためにパッチモードにします
let savevers_types = "*"        " カンマで区切られたバックアップを作成するファイル名です *.c,*.h,*.vim
let savevers_dirs = &backupdir  " バックアップファイルが書き込まれるディレクトリです ここでは、オプション'backupdir'と同じディレクト
let versdiff_no_resize=1        " バックアップファイルとの比較でウィンドウのサイズを変更する場合は0
let savevers_max = 99           " 
nnoremap <silent> <Space>sd- :VersDiff -<cr>
nnoremap <silent> <Space>sd+ :VersDiff +<cr>
nnoremap <silent> <Space>sdc :VersDiff -c<cr>

"----------------------------------------
" qfixhowm.vim
let MyGrep_ExcludeReg = '[~#]$\|\.dll$\|\.exe$\|\.lnk$\|\.o$\|\.obj$\|\.pdf$\|\.xls$\|[/\\]\.svn[/\\]'

"----------------------------------------
" EnhancedCommentify.vim
nnoremap <Space>/ :call EnhancedCommentify('', 'guess')<CR>
vnoremap <Space>/ :call EnhancedCommentify('', 'guess')<CR>

"----------------------------------------
" neocomplecache.vim
function! InsertTabWrapper()
    if pumvisible()
        return "\<c-n>"
    endif
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k\|<\|/'
        return "\<tab>"
    elseif exists('&omnifunc') && &omnifunc == ''
        return "\<c-n>"
    else
        return "\<c-x>\<c-o>"
    endif
endfunction
function! InsertShiftTabWrapper()
    if pumvisible()
        return "\<c-p>"
    endif
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k\|<\|/'
        return "\<S-tab>"
    elseif exists('&omnifunc') && &omnifunc == ''
        return "\<c-p>"
    else
        return "\<c-x>\<c-o>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-tab> <c-r>=InsertShiftTabWrapper()<cr>
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3

inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-l> neocomplcache#complete_common_string()
imap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g> neocomplcache#undo_completion()

"----------------------------------------
" ref.vim
if has('unix')
    let g:ref_phpmanual_path = '/Users/yanagikenji/.vim/php_doc/php-chunked-xhtml/'
endif
if has('win32')
    let g:ref_phpmanual_path = 'C:/Users/yanagikenji/.vim/php_doc/php-chunked-xhtml/'
endif

"----------------------------------------
" unite.vim
" 入力モードで開始する
"let g:unite_enable_start_insert=1
"let g:unite_source_file_mru_time_format
let g:vimfiler_as_default_explorer = 1
" バッファ一覧
nnoremap <silent> <Space>b  :<C-u>Unite buffer -horizontal -direction=botright -auto-resize<CR>
" ファイル一覧
nnoremap <silent> <Space>uf :<C-u>UniteWithBufferDir -buffer-name=files -direction=botright file -auto-resize<CR>
" レジスタ一覧
nnoremap <silent> <Space>ur :<C-u>Unite -buffer-name=register -direction=botright -auto-resize register<CR>
" 最近使用したファイル一覧
nnoremap <silent> <Space>m  :<C-u>Unite file_mru -direction=botright -auto-resize<CR>
" 常用セット
nnoremap <silent> <Space>uu :<C-u>Unite buffer file_mru -direction=botright -auto-resize<CR>
" 全部乗せ
nnoremap <silent> <Space>ua :<C-u>UniteWithBufferDir -buffer-name=files -direction=botright -auto-resize buffer file_mru bookmark file<CR>
" unite.vim上でのキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " 単語単位からパス単位で削除するように変更
  inoremap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " ESCキーを押すと終了する
  nmap <silent><buffer> <C-[> q
  nmap <silent><buffer> <ESC> q
endfunction

"----------------------------------------
" vim-filer.vim
nnoremap <Space>e  :VimFiler<CR>
let g:vimfiler_as_default_explorer = 1
call vimfiler#set_execute_file('vim', 'vim')
call vimfiler#set_execute_file('php', 'vim')
call vimfiler#set_execute_file('ctp', 'vim')
call vimfiler#set_execute_file('txt', 'vim')
call vimfiler#set_execute_file('jax', 'vim')
autocmd FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings() " ESCキーを押すと終了する
  nmap <silent><buffer> <C-[> <C-o><C-o>
  nmap <silent><buffer> <ESC> <C-o><C-o>
  nmap <silent><buffer> q     <C-o><C-o>
  nunmap   <buffer> j
  nunmap   <buffer> k
endfunction


