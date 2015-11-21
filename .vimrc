" skip if vim-tiny or vim-small
if !1 | finish | endif

if has('vim_starting')
   if &compatible
     set nocompatible
   endif
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim
  set rtp+=$GOPATH/src/github.com/mattn/gom/misc/vim
endif

call neobundle#begin(expand('$HOME/.vim/bundle/'))
if neobundle#load_cache()
  NeoBundleFetch 'Shougo/neobundle.vim'

  NeoBundle 'tpope/vim-sensible'            " Think of sensible.vim as one step above `'nocompatible'` mode: a universal set of defaults that (hopefully) everyone can agree on
  NeoBundle 'Shougo/vimproc.vim', {
  \   'build' : {
  \     'windows' : 'tools\\update-dll-mingw',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'linux' : 'make',
  \     'unix' : 'gmake',
  \   }
  \ }
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/neocomplete.vim', {
  \   'autoload' : {
  \     'insert' : 1,
  \   },
  \   'depends' : 'Shougo/context_filetype.vim',
  \   'disabled': !has('lua'),
  \   'vim_version':'7.3.885',
  \ }
  NeoBundle 'Shougo/neosnippet'
  NeoBundle 'Shougo/neosnippet-snippets'
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
  NeoBundle 'mattn/sonictemplate-vim.git'  " Easy and high speed coding method.
  NeoBundle 'wellle/targets.vim'           " Targets.vim adds various |text-objects| to give you more targets to operate on
  NeoBundle 'terryma/vim-expand-region'    " vim-expand-regions brings the incremental visual selection feature from other text editors into Vim.
  NeoBundle "kana/vim-smartinput"          " <C-v>{ smartinput is a Vim plugin to provide smart input assistant.
  NeoBundle 'tpope/vim-rsi'                " This plugin provides Readline (Emacs) mappings for insert and command line mode
  NeoBundle 'tpope/vim-repeat'
  NeoBundle 'pangloss/vim-javascript'      " Syntax highlighting and indenting for JSX
  NeoBundle 'mxw/vim-jsx'                  " Syntax highlighting and indenting for JSX
  NeoBundle 'svermeulen/vim-easyclip'      " Simplified clipboard functionality for Vim.
  NeoBundle 'isRuslan/vim-es6'             " Write JavaScript ES6 easily with vim.
  NeoBundle 'moll/vim-node'                " Tools to make Vim superb for developing with Node.js.
  NeoBundleLazy 'lambdalisue/unite-grep-vcs', { 'autoload': { 'unite_sources': ['grep/git', 'grep/hg'] }}
  NeoBundleLazy 'OrangeT/vim-csharp', { 'autoload': { 'filetypes': [ 'cs', 'csi', 'csx' ] } }
  NeoBundle 'cohama/vim-hier'              " Highlight quickfix errors and location list entries in buffer
  NeoBundleLazy 'fatih/vim-go', { 'autoload' : { 'filetypes' : 'go'  } }
  NeoBundle 'rhysd/committia.vim'
  if has("mac")
    NeoBundle 'Keithbsmiley/swift.vim'
  endif

  NeoBundleSaveCache
endif
call neobundle#end()

filetype plugin indent on
NeoBundleCheck

"----------------------------------------
" settings
set nocompatible
set t_Co=256            " 256色に
" カラースキーム設定
colorscheme desert
hi SpecialKey ctermfg=darkgreen

set guioptions=mr
set ignorecase          " 文字小文字を判別しない
set smartcase           " でも大文字小文字が混ざって入力されたら区別する
set tabstop=2           " 2タブ
set shiftwidth=2        " 2タブ
set softtabstop=0       " タブキー押下時に挿入される文字幅を指定。(0の場合「tabstop」で指定されている数値が使用される)
set expandtab           " タブを空白に
set nowrap              " 折り返さない
set nowrapscan          " ファイルの末尾で折り返さない
set cmdheight=1         " コマンドラインの高さ(GUI使用時)
set statusline=%n\:%F%=\ \|%Y\|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r<%l\|%c\|%L>
set cindent
set ambiwidth=double      " □や○の文字があってもカーソル位置がずれないようにする
set virtualedit=block     " ブロック選択時にフリーカーソルモード
set hidden                " バッファを切替えてもundoの効力を失わない
set backup
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/swap
set imsearch=0
set iminsert=0
set diffopt=filler,vertical,foldcolumn:0
set noundofile
set list
set listchars=tab:.\ 
set clipboard=unnamed,unnamedplus
set omnifunc=syntaxcomplete#Complete

" Don't redraw while macro executing.
set lazyredraw
if has('gui_macvim')
  set iskeyword=@,48-57,_,128-167,224-235
  set macmeta
endif
set shortmess+=A " swapファイルの警告を無効にする
set completeopt=menuone,longest

nnoremap [prefix] <Nop>
nmap     <Space> [prefix]

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
nnoremap ZQ <Nop>
nnoremap <silent>[prefix]w  :write<CR>
nnoremap <silent>[prefix]vi :e $HOME/dotfiles/.vimrc<CR>
vnoremap <silent> / y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap <silent> ? y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" Command mode keymappings:
cnoremap <C-k>  <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <C-v> <C-r>"

"----------------------------------------
" command

" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" Auto change local current directory to git-root
function! ChangeCurrentDirectoryToProjectRoot()
  let root = unite#util#path2project_directory(expand('%'))
  execute 'lcd' root
endfunction
autocmd BufEnter * :call ChangeCurrentDirectoryToProjectRoot()

autocmd BufRead,BufNewFile *.jbuilder set filetype=ruby
autocmd BufRead,BufNewFile *.mm set filetype=objc
autocmd FileType vim,text setlocal textwidth=0
autocmd FileType html,smarty setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/

function! s:OpenMemo()
  execute "e $HOME/Dropbox/vim/Amemo.txt"
endfunction
command! Memo call s:OpenMemo()

if neobundle#tap('vim-quickrun')
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
  call neobundle#untap()
endif
nmap <silent> [prefix]r <Plug>(quickrun)

if neobundle#tap('neocomplete.vim')
  let g:acp_enableAtStartup = 0
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  let g:neocomplete#enable_auto_delimiter             = 1
  let g:neocomplete#enable_refresh_always             = 1

  " for vim-lua-plugin
  let g:neocomplete#force_overwrite_completefunc      = 1
  if !exists('g:neocomplete#sources#omni#functions')
      let g:neocomplete#sources#omni#functions        = {}
  endif
  if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns     = {}
  endif
  let g:neocomplete#sources#omni#functions.lua        = 'xolox#lua#omnifunc'
  " let g:neocomplete#sources#omni#input_patterns.lua = '\w\+[.:]\|require\s*(\?["'']\w*'
  let g:neocomplete#force_omni_input_patterns.lua     = '\w\+[.:]\|require\s*(\?["'']\w*'

  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g> neocomplete#undo_completion()
  inoremap <expr><C-l> neocomplete#complete_common_string()

  " <TAB>: completion.
  inoremap <expr><TAB> pumvisible() ? "\<C-y>" : "\<TAB>"

  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

  if neobundle#tap('vim-enter-indent')
    function! neobundle#tapped.hooks.on_post_source(bundle)
      inoremap <expr><CR> pumvisible() ? "\<C-y>" : "\<C-R>=EnterIndent()\<CR>"
    endfunction
    call neobundle#untap()
  endif

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif

  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.go = '\h\w\.\w*'
  let g:neocomplete#sources#omni#input_patterns.php = '\h\w*->\h\w*\|\h\w\.\w*|\h\w*::'
  call neobundle#untap()
endif

if neobundle#tap('unite.vim')
  let g:unite_enable_start_insert = 1
  let g:unite_enable_short_source_names = 1
  let g:unite_split_rule = 'botright'
  let g:neomru#file_mru_path=expand($HOME.'/.vim/.neomru_file')
  let g:neomru#directory_mru_path=expand($HOME.'/.vim/.neomru_direcroty')

  nnoremap <silent> [prefix]m :<C-u>Unite file_mru -horizontal -direction=botright<CR>
  nnoremap [prefix]gr :<C-u>Unite -buffer-name=search-buffer -auto-preview grep:.<CR>
  nnoremap [prefix]ggr :<C-u>UniteWithInputDirectory -buffer-name=search-buffer -auto-preview grep:--unrestricted<CR>
  nnoremap <silent> [prefix]r :<C-u>UniteResume search-buffer<CR>
  nnoremap <silent> [prefix]p :<C-u>call DispatchUniteFileRecAsyncOrGit()<CR>
  function! DispatchUniteFileRecAsyncOrGit()
    if isdirectory(getcwd()."/.git")
      Unite file_rec/git
    else
      Unite file_rec/async
    endif
  endfunction

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
  call neobundle#untap()
endif

if neobundle#tap('vimfiler')
  let s:bundle = neobundle#get('vimfiler')
  function! s:bundle.hooks.on_source(bundle)
    autocmd FileType vimfiler call s:vimfiler_my_settings()
    function! s:vimfiler_my_settings()
      nmap <silent><buffer> [prefix]<Space> <Plug>(vimfiler_toggle_mark_current_line)k
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
  nnoremap <silent> [prefix]e  :VimFilerBufferDir<CR>
  call neobundle#untap()
endif

if neobundle#tap('vim-fugitive')
  let g:Gitv_DoNotMapCtrlKey = 0
  nnoremap <silent> [prefix]gb :Gblame<CR>
  nnoremap <silent> [prefix]gd :Gdiff<CR>zR<C-W>hgg]c
  nnoremap <silent> [prefix]gD :Gdiff HEAD<CR>zR<C-W>hgg]c
  nnoremap <silent> [prefix]gl :Gitv!<CR>
  nnoremap <silent> [prefix]gs :Gstatus<CR>
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

  if neobundle#tap('gitv')
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
  endif
  call neobundle#untap()
endif

if neobundle#tap('syntastic')
  " syntastic.vim :Errors
  let g:syntastic_ignore_files=['\.tpl$','\.m$','\.jsx$']
  let g:syntastic_auto_loc_list=2
  let g:syntastic_mode_map={ 
    \ 'mode': 'active', 
    \ 'active_filetypes': ['javascript', 'go'], 
    \ 'passive_filetypes': [] 
  \ }
  let g:syntastic_javascript_jshint_args = '--config "' . $HOME . '/.jshintrc"'
  let g:syntastic_go_checkers = ['go', 'golint']
  let g:syntastic_php_checkers = ['php']
  call neobundle#untap()
endif

if neobundle#tap('gundo.vim')
  nmap U :<C-u>GundoToggle<CR>
  call neobundle#untap()
endif

if neobundle#tap('lightline.vim')
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
  call neobundle#untap()
endif

if neobundle#tap('PreserveNoEOL')
  let g:PreserveNoEOL = 1
  call neobundle#untap()
endif

if neobundle#tap('tcomment_vim')
  let g:tcommentMapLeaderOp1="[prefix]c"
  call neobundle#untap()
endif

if neobundle#tap('vim-ref.git')
  " ruby: sudo gem install refe2 bitclust-dev
  "       bitclust setup
  let g:ref_phpmanual_path = $HOME.'/.vim/doc/php-chunked-xhtml'
  autocmd FileType ref-phpmanual,ref-refe call s:initialize_ref_viewer()
  function! s:initialize_ref_viewer()
    nnoremap <buffer> q c
  endfunction
  call neobundle#untap()
endif

if neobundle#tap('vim-go')
  let g:go_fmt_autosave = 1
  let g:go_fmt_fail_silently = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  call neobundle#untap()
endif

if neobundle#tap('neosnippet')
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)

  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  " For conceal markers.
  if has('conceal')
    set conceallevel=2 concealcursor=niv
  endif
  call neobundle#untap()
endif
