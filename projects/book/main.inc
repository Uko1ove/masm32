include \masm32\include\masm32rt.inc
include \masm32\include\msvcrt.inc

include \masm32\macros\macros.asm

includelib \masm\lib\msvcrt.lib
;--------------------------------------

MainProc		proto :DWORD
PHONE struct
	szName		db 256 dup(?)
	szPhone		db 256 dup(?)
	
PHONE ends





.const





.data?

ir				INPUT_RECORD <>
ph				PHONE <>
szTempBuffer	db 256 dup(?)


.data

szStr1		db "Add <key 1>, View <key 2>, Quit <key q>",0
szStr2		db "Enter a name <empty line to quit>",0
szStr3		db "Enter a phone nuber <empty line to quit>",0
;------------------------------------------------
szClear		db "cls",0
szDone		db "Done!",0
szName		db "Name:",9,0
szPhone		db "Phone:",9,0
szEmpty		db "The book is empty",0