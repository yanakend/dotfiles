syntax on
if has('win32')
    colorscheme user_color      "カラースキーム設定
endif
if has('unix')
    colorscheme desert          "カラースキーム設定
endif

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set guioptions=mr

set nocompatible                    "viとの互換性を取らない
set number                          "行数表示
set hlsearch                        "検索文字列を色づけ
set ignorecase                      "大文字小文字を判別しない
set incsearch                       "インクリメンタルサーチ
set nowrapscan                      "検索をファイルの末尾まで検索したら、ファイルの先頭へループする
set noterse                         "ファイルの端まで検索してしまったときのメッセージが表示しない
set smartcase                       "でも大文字小文字が混ざって入力されたら区別する
set tabstop=4                       "4タブ
set shiftwidth=4                    "4タブ
set expandtab                       "タブを空白に
set wrap!                           "折り返さない
set cmdheight=1                     "コマンドラインの高さ(GUI使用時)
set ignorecase
set smartcase
set showcmd                         " 入力中のコマンドをステータスに表示する
set laststatus=2                    " ステータスラインを常に表示
set statusline=%n\:%F%=\ \|%Y\|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r<%l/%L:%p%%>
set autoindent
set cindent
"set shellslash                      "Windowsでディレクトリパスの区切り文字表示に / を使えるようにする
set ambiwidth=double                "□や○の文字があってもカーソル位置がずれないようにする
set whichwrap=b,s,[,],<,>           "カーソルキーで行末／行頭の移動可能に設定
set vb t_vb=                        "ビープ音を鳴らさない
set title                           " タイトルをウインドウ枠に表示する
set hidden                          " バッファを切替えてもundoの効力を失わない
set shortmess+=I                    " 起動時のメッセージを表示しない

set backup
set writebackup
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set imsearch=0
set iminsert=0

"----------------------------------------
" map
nnoremap h zv<Left>
nnoremap j gj
nnoremap k gk
nnoremap l zv<Right>

if has('unix')
    nnoremap Y y$
"nnoremap <silent> <Space>y :.w !pbcopy<CR><CR>
"vnoremap <silent> <Space>y :w !pbcopy<CR><CR>
"nnoremap <silent> <Space>p :r !pbpaste<CR>
"vnoremap <silent> <Space>p :r !pbpaste<CR>

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
endif

nnoremap <C-]> :noh<CR>
nnoremap ZZ <Nop>

nnoremap <Space>e  :Exp<CR>
nnoremap <Space>d  :Kwbd<CR>
nnoremap <Space>w  :write<CR>
nnoremap <Space>m  :MRU<CR>
nnoremap <Space>g  :Grep<CR>
nnoremap <Space>td :Td<CR>
nnoremap <Space>tl :Tl<CR>

nnoremap <C-h>     <C-w>h
nnoremap <C-j>     <C-w>j
nnoremap <C-k>     <C-w>k
nnoremap <C-l>     <C-w>l

nnoremap <silent> <Space>co :ContinuousNumber <C-a><CR>
vnoremap <silent> <Space>co :ContinuousNumber <C-a><CR>
vnoremap <silent> /  :<C-u>call MySetSearch('""vgvy')<CR>:let &hlsearch=&hlsearch<CR>
nnoremap <C-g> `.

"----------------------------------------
" command
command!                 Td    :silent !start "C:\Program files\TortoiseSVN\bin\TortoiseProc.exe" /command:diff              /path:"%" /notempfile /closeonend<CR>
command!                 Tl    :silent !start "C:\Program files\TortoiseSVN\bin\TortoiseProc.exe" /command:log               /path:"%" /notempfile /closeonend<CR>
command!                 Kwbd  let kwbd_bn= bufnr("%")|enew|exe "bd ".kwbd_bn|unlet kwbd_bn 
command!                 Grep  :silent !"C:\Program Files\Yokka\NoEditor\Grep.exe.lnk"<CR>
command!                 Cp932 edit ++enc=cp932
command!                 Eucjp edit ++enc=euc-jp
command!                 Iso2022jp edit ++enc=iso-2022-jp
command!                 UTF8 edit ++enc=utf-8
command!                 Jis Iso2022jp
command!                 Sjis Cp932
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor

"----------------------------------------
" function
""""""""""""""""""""""""""""""
"検索ワードをセットする。
"何か追加パラメータが設定されていたら、単語単位検索に。
""""""""""""""""""""""""""""""
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
" neocomplete.vim
let g:neocomplcache_enable_at_startup = 1

"----------------------------------------
" quickrun.vim
"let g:quickrun_no_default_key_mappings = 0
silent! nnoremap <unique> <Space>r <Plug>(quickrun)

"----------------------------------------
" savevers.vim
set patchmode=.clean            " バックアップファイルの設定" savevers.vimのためにパッチモードにします
let savevers_types = "*"        " カンマで区切られたバックアップを作成するファイル名です "*.c,*.h,*.vim"
let savevers_dirs = &backupdir  " バックアップファイルが書き込まれるディレクトリです ここでは、オプション"backupdir"と同じディレクト
let versdiff_no_resize=1        " バックアップファイルとの比較でウィンドウのサイズを変更する場合は0
let savevers_max = 99           " 
nnoremap <silent> <Space>sd- :VersDiff -<cr>
nnoremap <silent> <Space>sd+ :VersDiff +<cr>
nnoremap <silent> <Space>sdc :VersDiff -c<cr>

