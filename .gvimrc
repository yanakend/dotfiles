" メニューバー非表示
set guioptions-=T

colorscheme desert
if has('win32')
  set guifont=meiryoke_Gothic:h10:cSHIFTJIS
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
  if &diff
    au GUIEnter * simalt ~x zR
    set nofoldenable
  endif
endif
if has('gui_macvim')
  set guifont=Ricty-Regular:h16
  set transparency=10	" 透明度を指定
  set antialias
  set guioptions-=r
  set guioptions-=R
  set noimdisableactivate
  set lsp=0
endif

set cmdheight=1      " コマンドラインの高さ(GUI使用時)
set visualbell t_vb= " エラーのときに、ビープ音を出さない
hi SpecialKey guibg=NONE guifg=Gray40

if has("gui_running")
  set lines=10000 columns=10000
endif 
