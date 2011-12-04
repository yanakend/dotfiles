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

set nocompatible                    " viとの互換性を取らない
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
" バッファを切替えてもundoの効力を失わない
"set shortmess+=I                    " 起動時のメッセージを表示しない

set backup
set writebackup
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set imsearch=0
set iminsert=0
set formatoptions-=ro

set diffopt=filler,vertical,foldcolumn:0
"zi do dp [c ]c diffoff!

"----------------------------------------
" map
nnoremap <silent> <C-[><C-[> :noh<CR>
nnoremap h zv<Left>
nnoremap j gj
nnoremap k gk
nnoremap l zv<Right>

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

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

nnoremap <Space>e  :Exp<CR>
nnoremap <Space>d  :bd<CR>
nnoremap <Space>w  :write<CR>
nnoremap <Space>m  :MRU<CR>
nnoremap <Space>v  :e ~/.vimrc<CR>
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
nnoremap <C-g> `.

cnoremap <C-a>    <Home>
cnoremap <C-f>    <Right>
cnoremap <C-b>    <Left>
cnoremap <C-d>    <Delete>
cnoremap <C-w>     <Home>\<<End>\><Left><Left>
cnoremap <C-c>     <End>\C

vnoremap <         <gv
vnoremap >         >gv

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
" quickbuf.vim
let g:qb_hotkey = "<Space>b"

"----------------------------------------
" quickrun.vim
"let g:quickrun_no_default_key_mappings = 0
"silent! nnoremap <Space>r <Plug>(quickrun)

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
nnoremap <Space>c :call EnhancedCommentify('', 'guess')<CR>
vnoremap <Space>c :call EnhancedCommentify('', 'guess')<CR>

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
inoremap <expr><C-h> neocomplcache#smart_close_popup().”\<C-h>
inoremap <expr><C-l> neocomplcache#complete_common_string()
imap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g> neocomplcache#undo_completion()



