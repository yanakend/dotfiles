
" Vim color file
" Maintainer:	
" Last Change:	

hi clear
syntax reset
syntax on

let colors_name = "user_color"

"------------------------------
"	color clear
"------------------------------
"hi clear SpecialKey

"------------------------------
"	color default
"------------------------------
"set highlight=n:ErrorMsg

"------------------------------
"	color
"------------------------------
hi Normal				gui=None			guifg=Black			guibg=Grey85		"通常
hi NonText				gui=None			guifg=Grey60							"改行コード等
hi SpecialKey			gui=None			guifg=Grey60							"tab
hi Cursor									guifg=Black			guibg=Red			"カーソル
"hi Cursor									guifg=Black			guibg=Cyan			"カーソル
"hi Cursorline			gui=Underline							guibg=Grey85		"カーソル行
hi Cursorline			gui=None								guibg=Cyan
hi lCursor									guifg=Black			guibg=Black			"カーソル 点滅
hi CursorIM									guifg=Black			guibg=Green			"カーソル IME_ON時
hi IncSearch			gui=NONE			guifg=Black			guibg=Yellow		"インクリメンタル検索
hi Search				gui=NONE			guifg=Black			guibg=Yellow		"検索
hi Number				gui=NONE			guifg=#950095							"数字
hi Comment				gui=NONE			guifg=DarkGreen							"コメント
hi PreProc				gui=NONE			guifg=Blue								"プリプロセッサ
hi cConstant			gui=None			guifg=Black			guibg=Grey85		"C定数(NULL)
hi Type					gui=NONE			guifg=Blue								"修飾子
hi Statement			gui=NONE			guifg=Blue								"予約語
hi Identifier			gui=None			guifg=Black								"hasとか…？
hi TabLineSel			gui=NONE													"選択タブ
hi TabLine				gui=Reverse													"非選択タブ
hi TabLineFill								guifg=Black			guibg=Black			"タブ欄
hi Visual									guifg=White			guibg=#008080		"ビジュアルモード
hi ModeMsg				gui=NONE													"モードメッセージ
hi MoreMsg				gui=NONE			guifg=Black								"
hi StatusLine			gui=Reverse,NONE											"現在ステータスライン
hi StatusLineNr			gui=Reverse													"ステータスライン
hi Special				gui=NONE			guifg=Brown								"\t\n
hi VimMapRhs			gui=NONE			guifg=Brown								"文字列
hi String				gui=NONE			guifg=Brown								"文字列
hi Character			gui=NONE			guifg=Brown								"文字定数
hi Todo					gui=NONE			guifg=Black			guibg=Grey85		"TODO
hi MatchParen			gui=NONE			guifg=Black			guibg=Grey85		"対応するカッコ
hi Constant				gui=None			guifg=Black								"true false
hi Ignore									guifg=Black								"|（パイプ）
hi makeCommands			gui=NONE													"[   SeqAssemble ..... $<   ]
hi Label				gui=NONE													"ラベル
hi LineNr				gui=NONE			guifg=White			guibg=Black			"行
hi Directory			gui=NONE			guifg=Black								"タグジャンプ時とかに出てくるディレクトリパス

hi ErrorMsg									guifg=White			guibg=Red			"
hi StatusLineNC			gui=Reverse													"
hi VertSplit			gui=Reverse													"
hi VisualNOS			gui=Underline,NONE											"
hi CursorColumn													guibg=Grey100		"
hi Question				gui=NONE			guifg=Green								"
hi Title				gui=NONE			guifg=Magenta							"
hi WarningMsg								guifg=Red								"
hi WildMenu				gui=NONE,Underline	guifg=Black			guibg=Yellow		"
hi Folded									guifg=DarkBlue		guibg=LightGrey		"
hi FoldColumn								guifg=DarkBlue		guibg=Grey			"
hi DiffText				gui=NONE								guibg=Red			"
hi DiffAdd														guibg=DarkBlue		"
hi DiffChange													guibg=DarkMagenta	"
hi DiffDelete			gui=NONE			guifg=Blue			guibg=DarkCyan		"
"hi ZenkakuSpace			gui=None													"全角スペース

" ----- 文法定義(ハイライト) ---------------------
"match ZenkakuSpace /　/

"hi Pmenu		guibg=DarkGray
"hi Pmenusel		guibg=DarkBlue
"hi PmenuSbar	guibg=DarkRed


" block comments
"vmap ,b v`<I<CR><esc>k0i/*<ESC>`>j0i*/<CR><esc><ESC>
"vmap ,h v`<I<CR><esc>k0i<!--<ESC>`>j0i--><CR><esc><ESC>

syntax match	InvisibleTrailedSpace	"[abc]\+$" display containedin=ALL
highlight		InvisibleTrailedSpace	gui=underline guibg=Red
syntax match	InvisibleTab			"\t" display containedin=ALL
highlight		InvisibleTab			term=underline ctermbg=Cyan guibg=Cyan
















