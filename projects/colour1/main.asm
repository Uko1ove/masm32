.686
.model flat,stdcall
option casemap:none

comment* ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

            Console Color Template
            New way to use comments - between 2 stars 

 ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл *

include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc          ;--for working with C functions

include \masm32\macros\macros.asm           ;--macros

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

Quit    proto

.const





.data?





.data





.code
start:

    call main
    ;------------------
    invoke Quit
    ;------------------
    
    invoke ExitProcess,0
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
main proc




    ret
main endp
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
Quit proc

    szText szExit,"Press any key..."                     ;--macros, creates within text string that can be used
    ;-------------------------------
    ccout(offset szExit)
    ;-------------------------------
    _while:
        invoke crt__kbhit                                ;--key button hit. checks press of the key end returns to eax value (1/0)
        test eax,eax
        je _while
        ;----------------
        invoke crt__getch                                ;--get char 
    ret
Quit endp
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл


end start
