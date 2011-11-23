
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
hi Normal				gui=None			guifg=Black			guibg=Grey85		"�ʏ�
hi NonText				gui=None			guifg=Grey60							"���s�R�[�h��
hi SpecialKey			gui=None			guifg=Grey60							"tab
hi Cursor									guifg=Black			guibg=Red			"�J�[�\��
"hi Cursor									guifg=Black			guibg=Cyan			"�J�[�\��
"hi Cursorline			gui=Underline							guibg=Grey85		"�J�[�\���s
hi Cursorline			gui=None								guibg=Cyan
hi lCursor									guifg=Black			guibg=Black			"�J�[�\�� �_��
hi CursorIM									guifg=Black			guibg=Green			"�J�[�\�� IME_ON��
hi IncSearch			gui=NONE			guifg=Black			guibg=Yellow		"�C���N�������^������
hi Search				gui=NONE			guifg=Black			guibg=Yellow		"����
hi Number				gui=NONE			guifg=#950095							"����
hi Comment				gui=NONE			guifg=DarkGreen							"�R�����g
hi PreProc				gui=NONE			guifg=Blue								"�v���v���Z�b�T
hi cConstant			gui=None			guifg=Black			guibg=Grey85		"C�萔(NULL)
hi Type					gui=NONE			guifg=Blue								"�C���q
hi Statement			gui=NONE			guifg=Blue								"�\���
hi Identifier			gui=None			guifg=Black								"has�Ƃ��c�H
hi TabLineSel			gui=NONE													"�I���^�u
hi TabLine				gui=Reverse													"��I���^�u
hi TabLineFill								guifg=Black			guibg=Black			"�^�u��
hi Visual									guifg=White			guibg=#008080		"�r�W���A�����[�h
hi ModeMsg				gui=NONE													"���[�h���b�Z�[�W
hi MoreMsg				gui=NONE			guifg=Black								"
hi StatusLine			gui=Reverse,NONE											"���݃X�e�[�^�X���C��
hi StatusLineNr			gui=Reverse													"�X�e�[�^�X���C��
hi Special				gui=NONE			guifg=Brown								"\t\n
hi VimMapRhs			gui=NONE			guifg=Brown								"������
hi String				gui=NONE			guifg=Brown								"������
hi Character			gui=NONE			guifg=Brown								"�����萔
hi Todo					gui=NONE			guifg=Black			guibg=Grey85		"TODO
hi MatchParen			gui=NONE			guifg=Black			guibg=Grey85		"�Ή�����J�b�R
hi Constant				gui=None			guifg=Black								"true false
hi Ignore									guifg=Black								"|�i�p�C�v�j
hi makeCommands			gui=NONE													"[   SeqAssemble ..... $<   ]
hi Label				gui=NONE													"���x��
hi LineNr				gui=NONE			guifg=White			guibg=Black			"�s
hi Directory			gui=NONE			guifg=Black								"�^�O�W�����v���Ƃ��ɏo�Ă���f�B���N�g���p�X

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
"hi ZenkakuSpace			gui=None													"�S�p�X�y�[�X

" ----- ���@��`(�n�C���C�g) ---------------------
"match ZenkakuSpace /�@/

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
















