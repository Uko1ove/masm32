include \masm32\include\masm32rt.inc
include \masm32\include\msvcrt.inc

include \masm32\macros\macros.asm

includelib \masm\lib\msvcrt.lib
;--------------------------------------

MainProc		proto
ShowProc		proto

POSITION struct
	x dw ?
	y dw ?
POSITION ends

.const





.data?
pos			POSITION <>
szBuffer	db 12 dup(?)


.data
szFrm		db "%i%c",13,10,0
szFrm2		db "Formarring drive %c:",13,10,13,10,0


