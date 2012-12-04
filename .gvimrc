set guioptions-=T               " メニューバー非表示
colorscheme desert
if has('win32')
    set guifont=meiryoke_Gothic:h10:cSHIFTJIS       "Windows用
    " 一部のUCS文字の幅を自動計測して決める
    if has('kaoriya')
      set ambiwidth=auto
    endif
endif
if has('gui_macvim')
	set transparency=1	" 透明度を指定
	set antialias
    "set imdisable		" IMを無効化

endif
