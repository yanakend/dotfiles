"--------------------------------------------------------------------------------
" plugin
if has('vim_starting')
  set nocp
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'tpope/vim-sensible'            " Think of sensible.vim as one step above `'nocompatible'` mode: a universal set of defaults that (hopefully) everyone can agree on
NeoBundle 'Shougo/vimproc', {
      \'build': {
      \  'cygwin': 'make -f make_cygwin.mak',
      \  'mac': 'make -f make_mac.mak',
      \  'unix': 'make -f make_unix.mak',
      \},
      \ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'tsukkee/unite-tag'
NeoBundleLazy 'Shougo/vimfiler'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'acustodioo/vim-enter-indent'
NeoBundle 'scrooloose/syntastic'
NeoBundleLazy 'vim-scripts/Align'        " :Align =>
NeoBundleLazy 'sjl/gundo.vim'
NeoBundle 'gregsexton/gitv'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'vim-scripts/PreserveNoEOL'
NeoBundle 'thinca/vim-localrc'           " Enable configuration file of each directory. .local.vimrc
NeoBundle 'tpope/vim-surround'
NeoBundleLazy 'vim-scripts/DirDiff.vim'
NeoBundleLazy 'thinca/vim-ref.git'
NeoBundleLazy 'taka84u9/vim-ref-ri.git'
NeoBundle 'wellle/targets.vim'           " Targets.vim adds various |text-objects| to give you more targets to operate on
" NeoBundle 'mustache/vim-mustache-handlebars'
NeoBundle 'terryma/vim-expand-region'    " vim-expand-regions brings the incremental visual selection feature from other text editors into Vim.
" NeoBundle 'tpope/vim-sleuth'             " This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
NeoBundle "kana/vim-smartinput"          " smartinput is a Vim plugin to provide smart input assistant.
NeoBundle 'tpope/vim-rsi'                " This plugin provides Readline (Emacs) mappings for insert and command line mode
NeoBundle 'tpope/vim-repeat'
NeoBundle 'svermeulen/vim-easyclip'      " Simplified clipboard functionality for Vim.
NeoBundleLazy 'lambdalisue/unite-grep-vcs', { 'autoload': { 'unite_sources': ['grep/git', 'grep/hg'] }}
NeoBundleLazy 'OrangeT/vim-csharp', { 'autoload': { 'filetypes': [ 'cs', 'csi', 'csx' ] } }

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

"----------------------------------------
" settings
set nocompatible        " viとの互換性を取らない
set t_Co=256            " 256色に
" カラースキーム設定
colorscheme desert
hi SpecialKey ctermfg=darkgreen

set encoding=utf-8
set guioptions=mr
set ignorecase          " 文字小文字を判別しない
set incsearch           " インクリメンタルサーチ
set smartcase           " でも大文字小文字が混ざって入力されたら区別する
set tabstop=2           " 2タブ
set shiftwidth=2        " 2タブ
set expandtab           " タブを空白に
set nowrap              " 折り返さない
set nowrapscan          " ファイルの末尾で折り返さない
set cmdheight=1         " コマンドラインの高さ(GUI使用時)
set statusline=%n\:%F%=\ \|%Y\|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r<%l\|%c\|%L>
set cindent
set ambiwidth=double      " □や○の文字があってもカーソル位置がずれないようにする
set title                 " タイトルをウインドウ枠に表示する
set virtualedit=block     " ブロック選択時にフリーカーソルモード
set hidden                " バッファを切替えてもundoの効力を失わない
set backup
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/swap
set imsearch=0
set iminsert=0
set linespace=4
set diffopt=filler,vertical,foldcolumn:0
set noundofile
set list
set listchars=tab:.\ 

" Don't redraw while macro executing.
set lazyredraw
if has('gui_macvim')
  set iskeyword=@,48-57,_,128-167,224-235
  set macmeta
endif
set shortmess+=A " swapファイルの警告を無効にする

"----------------------------------------
" map
if has('gui_macvim')
  nnoremap <silent> <C-[> :noh<CR>
else
  nnoremap <silent> <C-[><C-[> :noh<CR>
endif
nnoremap <silent> h zv<Left>
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> l zv<Right>

" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" windo diffthis
" diffoff!
nnoremap <silent> <C-h> :call CopyRightDiff()<CR>
nnoremap <silent> <C-j> :call NextDiff()<CR>
nnoremap <silent> <C-k> :call PrevDiff()<CR>
nnoremap <silent> <C-l> :call CopyLeftDiff()<CR>
function! NextDiff()
  if &diff
    silent normal! ]c
  else
    silent exe "normal \<c-w>j"
  endif
endfunction
function! PrevDiff()
  if &diff
    silent normal! [c
  else
    silent exe "normal \<c-w>k"
  endif
endfunction
function! CopyLeftDiff()
  if &diff
    silent normal! dp
  else
    silent exe "normal \<c-w>l"
  endif
endfunction
function! CopyRightDiff()
  if &diff
    silent normal! do
  else
    silent exe "normal \<c-w>h"
  endif
endfunction

nnoremap ZZ <Nop>
nnoremap <silent><Space>w  :write<CR>
nnoremap <silent><Space>vi :e $HOME/.vimrc<CR>
vnoremap <silent> / y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap <silent> ? y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" Command mode keymappings:
cnoremap <C-k>  <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
inoremap <C-k>  <C-o>D
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <C-v> <C-r>"

"----------------------------------------
" command
autocmd BufRead,BufNewFile *.jbuilder set filetype=ruby
autocmd BufRead,BufNewFile *.mm set filetype=objc
autocmd FileType vim,text setlocal textwidth=0
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html,smarty setlocal omnifunc=htmlcomplete#CompleteTags includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType haskell setlocal tabstop=4 shiftwidth=4

function! s:OpenMemo()
  execute "e $HOME/Dropbox/vim/Amemo.txt"
endfunction
command! Memo call s:OpenMemo()

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
let g:quickrun_config["java"] = {
      \ 'exec' : ['javac -J-Dfile.encoding=UTF8 %o %s', '%c -Dfile.encoding=UTF8 %s:t:r %a']
\}

if has("mac")
  " quickrun
  let g:quickrun_config['swift'] = {
  \ 'command': 'swift',
  \ 'cmdopt': '-sdk /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk',
  \ 'exec': '%c %o %s',
  \}
endif

function! s:QuickTest(arg1)
  execute "e $HOME/Dropbox/vim/test.".a:arg1
endfunction
command! -nargs=1 Quick call s:QuickTest(<f-args>)

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
      \ 'php'  : $HOME . '/dotfiles/.vim/dict/php.dict',
      \ 'ruby' : $HOME . '/dotfiles/.vim/dict/ruby.dict',
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

if !exists('g:neocomplcache_next_keyword_patterns')
  let g:neocomplcache_next_keyword_patterns = {}
endif

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
inoremap <expr><C-n> pumvisible() ? neocomplcache#manual_keyword_complete() : "\<Down>"

"----------------------------------------
" unite.vim
let g:unite_enable_start_insert = 1
let g:unite_enable_short_source_names = 1
let g:unite_split_rule = 'botright'
let g:neomru#file_mru_path=expand($HOME.'/.vim/.neomru_file')
let g:neomru#directory_mru_path=expand($HOME.'/.vim/.neomru_direcroty')

" 最近使用したファイル一覧
nnoremap <silent> <Space>m :<C-u>Unite file_mru -horizontal -direction=botright<CR>
" grep
nnoremap <Space>gr :<C-u>Unite -buffer-name=search-buffer -auto-preview grep:.<CR>
nnoremap <Space>ggr :<C-u>UniteWithInputDirectory -buffer-name=search-buffer -auto-preview grep:--unrestricted<CR>
" grep検索結果の再呼出
nnoremap <silent> <Space>r :<C-u>UniteResume search-buffer<CR>
" fuzzy-finder
nnoremap <silent> <Space>p :<C-u>call DispatchUniteFileRecAsyncOrGit()<CR>
function! DispatchUniteFileRecAsyncOrGit()
  if isdirectory(getcwd()."/.git")
    Unite file_rec/git
  else
    Unite file_rec/async
  endif
endfunction

" Auto change local current directory to git-root
function! ChangeCurrentDirectoryToProjectRoot()
  let root = unite#util#path2project_directory(expand('%'))
  execute 'lcd' root
endfunction
autocmd BufEnter * :call ChangeCurrentDirectoryToProjectRoot()

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '-S --nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_max_candidates = 200
endif

" unite.vim上でのキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " 単語単位からパス単位で削除するように変更
  inoremap <silent><buffer> <C-w> <Plug>(unite_delete_backward_path)
  imap <silent><buffer> <C-j> <Down>
  imap <silent><buffer> <C-k> <Up>
  nmap <silent><buffer> <C-[> <Plug>(unite_exit)
  nmap <silent><buffer> <ESC> <Plug>(unite_exit)
endfunction

"----------------------------------------
" vim-filer.vim
let s:bundle = neobundle#get('vimfiler')
function! s:bundle.hooks.on_source(bundle)
  autocmd FileType vimfiler call s:vimfiler_my_settings()
  function! s:vimfiler_my_settings()
    nmap <silent><buffer> <Space><Space> <Plug>(vimfiler_toggle_mark_current_line)k
    " ESCキーを押すと終了する
    nmap <silent><buffer> <C-[> q
    nmap <silent><buffer> <ESC> q
    " map N as search
    nunmap <buffer> N
    " map i as new file
    nmap <silent><buffer> i <Plug>(vimfiler_new_file)
    nmap <buffer><expr> l vimfiler#smart_cursor_map( "\<Plug>(vimfiler_smart_l)", "\<Plug>(vimfiler_edit_file)")
  endfunction
  " vimfilerをデフォルトのファイラにする
  let g:vimfiler_as_default_explorer = 1
  " セーフモード無効化
  let g:vimfiler_safe_mode_by_default = 0
  " ファイル数が多い場合、これがないと/検索でヒットしない
  let g:vimfiler_draw_files_limit=1000
endfunction
nnoremap <silent> <Space>e  :VimFilerBufferDir<CR>

"------------------------------------
" vim-fugitive
let g:Gitv_DoNotMapCtrlKey = 0
nnoremap <silent> <Space>gb :Gblame<CR>
nnoremap <silent> <Space>gd :Gdiff<CR>zR<C-W>hgg]c
nnoremap <silent> <Space>gD :Gdiff HEAD<CR>zR<C-W>hgg]c
nnoremap <silent> <Space>gl :Gitv!<CR>
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

function! s:gitv_get_current_hash()
  return matchstr(getline('.'), '\[\zs.\{7\}\ze\]$')
endfunction

"------------------------------------
" syntastic.vim :Errors
let g:syntastic_ignore_files=['\.tpl$','\.m$']
let g:syntastic_auto_loc_list=2
let g:syntastic_mode_map={ 
  \ 'mode': 'active', 
  \ 'active_filetypes': ['javascript'], 
  \ 'passive_filetypes': [] 
\ }
let g:syntastic_javascript_jshint_args = '--config "' . $HOME . '/.jshintrc"'

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
" PreserveNoEOL
let g:PreserveNoEOL = 1

"------------------------------------
" tcomment_vim
let g:tcommentMapLeaderOp1="<Space>c"

"------------------------------------
" vim-ref
" ruby: sudo gem install refe2 bitclust-dev
"       bitclust setup
let g:ref_phpmanual_path = $HOME.'/.vim/doc/php-chunked-xhtml'
autocmd FileType ref-phpmanual,ref-refe call s:initialize_ref_viewer()
function! s:initialize_ref_viewer()
  nnoremap <buffer> q c
endfunction

"------------------------------------
" unite-tag
autocmd BufEnter *
\   if empty(&buftype)
\|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
\|  endif

autocmd BufEnter *
\   if empty(&buftype)
\|      nnoremap <buffer> <C-t> :<C-u>Unite jump<CR>
\|  endif

let g:mustache_abbreviations = 1

set clipboard=unnamed,unnamedplus
