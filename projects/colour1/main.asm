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

Quit        proto
setColor    proto :DWORD,:DWORD

.const
    Black           = 0
    Blue            = 1
    Green           = 2
    Cyan            = 3
    Red             = 4
    Magenta         = 5
    Brown           = 6
    LightGray       = 7
    DarkGray        = 8
    LightBlue       = 9
    LightGreen      = 10
    LightCyan       = 11
    LightRed        = 12
    LightMagenta    = 13
    Yellow          = 14
    White           = 15




.data?





.data





.code
start:
    fn SetConsoleTitle,"Console color demo"             ;--call SetConsoleTitle with parametr
    ;-------------------
    invoke setColor,LightGreen,Black
    

    call main
    ;------------------
    invoke Quit
    ;------------------
    
    invoke ExitProcess,0
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
main proc
    invoke crt_puts,chr$("Hello, world!",13,10)



    ret
main endp
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
Quit proc

    szText szExit,"Press any key..."                     ;--macros, creates within text string that can be used
    ;-------------------------------
    ccout(offset szExit)
    ;-------------------------------
    _while:
        test FUNC(crt__kbhit),eax                       ;--change with only one line
        je _while
        ;----------------
        invoke crt__getch                                ;--get char 
    ret
Quit endp
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
setColor proc uses ebx esi edi colorTxt:DWORD, colorBackground:DWORD

    xor ebx,ebx
    mov bl,byte ptr[colorBackground]
    ;-----------------
    shl bl,4                                                ;--shift left, we moved bg clor in senior 4 bits
    ;-----------------
    or bl,byte ptr[colorTxt]
    ;-----------------
    invoke SetConsoleTextAttribute,rv(GetStdHandle,-11),ebx ;--we used ebx from the very beginning, 'cause eax
                                                            ;-will be filled with handle.
    ;----------------



    ret
setColor endp

end start
