set guioptions-=T               " メニューバー非表示
if has('win32')
    colorscheme user_color      "カラースキーム設定
    set guifont=meiryoke_Gothic:h10:cSHIFTJIS       "Windows用
    " 一部のUCS文字の幅を自動計測して決める
    if has('kaoriya')
      set ambiwidth=auto
    endif
endif