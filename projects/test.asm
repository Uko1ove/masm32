.686P
.model flat, stdcall
;---------------------
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
extern ExitProcess@4:near
extern GetStdHandle@4:near                     
extern CloseHandle@4:near
extern WriteConsoleA@20:near
extern ReadConsoleA@20:near
extern wsprintfA:near                   
;---------------------
MAX_SIZE        equ     255



_DATA SEGMENT
    ExitCode    dd 0
    szIntro     db 13,10,"Press <q> to quite, or <a> to execute small",13,10,0
    szBuffer    db MAX_SIZE dup(0)
    szError     db "Input error! Please, try again.",13,10,0
    szSmall     db 07,"Hello! Here I am :)",13,10,0
_DATA ENDS


_TEXT SEGMENT

START:


    call main
;-------------------------
    push [ExitCode]
    call ExitProcess@4
;**************************************
main proc                                   ;--function main

    _do:
        push offset szIntro
        call cout
        ;-------------------
        _while_:
            push offset szBuffer
            call cin
            ;---------------
            mov al,byte ptr[szBuffer]
            ;----------------
            .if al=='q'
                jmp _do_end
            .elseif al =='a'
                call small
            .else
                push offset szError
                call cout
            .endif
;-------------------------------
            jmp _do
_do_end:

    ret
main endp
;***************************************
;ebp+8 - pStr - string pointer 

cout proc                                   ;--function of organization of output
    push ebp
    mov ebp,esp
    add esp,-8                              ;-create 2 local var for descriptor and 
    ;-----------                                num of written symbols
    push ebx
    push esi
    push edi
;---------------------
    push -11
    call GetStdHandle@4
    mov dword ptr[ebp-4],eax                ;--move handle from eax to local var 
    ;-------------
    mov esi,dword ptr[ebp+8]
    push esi
    call lens
    ;-------------
    push 0
    mov ebx,ebp                             ;cause we can't just push this address
    sub ebx,8
    ;-------------
    push ebx                                ;--var for number of written symbols
    push eax                                ;--string length saved from lens function
    push esi                                ;--string address
    push dword ptr[ebp-4]                   ;--handle
    call WriteConsoleA@20
    
;---------------------
    pop edi
    pop esi
    pop ebx
    mov esp,ebp
    pop ebp
    
    ret 4
cout endp
;***************************************
cin proc                                        ;--;function of organization of input
    push ebp
    mov ebp,esp
    add esp,-4                                  ;--only 1 var. We don't create var for
                                                ;handle, cause we will not use eax in
                                                ;procedures within. For num of entered sym
    ;---------------
    push ebx
    push esi
    push edi
;--------------------
    mov edi,dword ptr[ebp+8]
    ;----------------
    push -10
    call GetStdHandle@4
    ;----------------
    mov esi,ebp
    sub esi,4                                   ;--address of local var
    ;----------------
    push 0
    push esi                                    ;--string length
    push 255
    push edi                                    ;--buffer address
    push eax                                    ;--handle
    call ReadConsoleA@20
    ;-----------------
    sub dword ptr[esi],2                        ;--enter = +2 ASCII symbols: return carett
                                                ;-- and new line.
    mov esi,dword ptr[esi]
    ;-----------------
    mov byte ptr[edi+esi],0                     ;--example of index addressing
;--------------------
    pop edi
    pop esi
    pop ebx
    mov esp,ebp
    pop ebp
    
    ret 4
cin endp
;*****************************************
lens proc                                   ;--function returns tring length to eax
    push ebp
    mov ebp,esp
    push ebx
    push esi
    push edi
;----------------
    mov esi,dword ptr[ebp+8]                ;--address of string
    ;------------
    sub ecx,ecx
    ;------------
_while:                                     ;--we can give to it any name
    mov al,byte ptr[esi]
    cmp al,0
    jz _end_while
    ;-------------
    inc ecx
    inc esi
    jmp _while
    ;-------------
_end_while:
    mov eax,ecx
;----------------
    pop edi
    pop esi
    pop ebx
    mov esp,ebp
    pop ebp

    ret 4
lens endp
;*******************************************
small proc                                      ;--say hello and goodbye
    enter 0,0                   
    push ebx
    push esi
    push edi
;-----------------------
    push offset szSmall
    call cout
;-----------------------
    pop edi
    pop esi
    pop ebx
    leave
    ret                           
small endp
;-------------------------
_TEXT ENDS
END START