" Vim syntax file
" Language:	Smarty Templates
" Maintainer:	Manfred Stienstra manfred.stienstra@dwerg.net
" Last Change:  Mon Nov  4 11:42:23 CET 2002
" Filenames:    *.tpl
" URL:		http://www.dwerg.net/projects/vim/smarty.vim

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
  finish
endif
  let main_syntax = 'smarty'
endif

syn case ignore

runtime! syntax/html.vim

syn keyword smartyTagName capture config_load include include_php
syn keyword smartyTagName insert if elseif else ldelim rdelim literal
syn keyword smartyTagName php section sectionelse foreach foreachelse
syn keyword smartyTagName strip assign counter cycle debug eval fetch
syn keyword smartyTagName html_options html_select_date html_select_time
syn keyword smartyTagName math popup_init popup html_checkboxes html_image
syn keyword smartyTagName html_radios html_table mailto textformat

syn keyword smartyModifier cat capitalize count_characters count_paragraphs
syn keyword smartyModifier count_sentences count_words date_format default
syn keyword smartyModifier escape indent lower nl2br regex_replace replace
syn keyword smartyModifier spacify string_format strip strip_tags truncate
syn keyword smartyModifier upper wordwrap

syn clear htmlError
syn region smartyZone start="{" end="}"  contains=smartyTagName, smartyModifier
syn region htmlComment start=+{\*+    end=+\*}+ contains=@Spell

if version >= 508 || !exists("did_smarty_syn_inits")
  if version < 508
    let did_smarty_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  hi smartyZone guifg=White guibg=grey20
  HiLink smartyTagName Identifier
  HiLink smartyModifier Function
"  HiLink smartyInFunc Function
"  HiLink smartyBlock Constant
"  HiLink smartyDot SpecialChar
  delcommand HiLink
endif

let b:current_syntax = "smarty"

if main_syntax == 'smarty'
  unlet main_syntax
endif

" vim: ts=8

