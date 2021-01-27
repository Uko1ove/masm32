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
STD_INP_HANDLE  equ     -10
STD_OUT_HANDLE  equ     -11



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
            jmp _while_
_do_end:
    ret
main endp
;***************************************
;ebp+8 - pStr - string pointer 

dwHout  equ [ebp-4]                         ;--we create constant, local var for handle
dwCnt   equ [ebp-8]                         ;--var for count
pStr    equ [ebp+8]                         ;--parametr in function
;---------------------------
cout proc                                   ;--function of organization of output
    push ebp
    mov ebp,esp
    add esp,-8                              ;-create 2 local var for descriptor and 
    ;-----------                                num of written symbols
    push ebx
    push esi
    push edi
;---------------------
    push STD_OUT_HANDLE
    call GetStdHandle@4
    mov dword ptr[dwHout],eax               ;--move handle from eax to local var 
    ;-------------
    mov esi,dword ptr[pStr]
    push esi
    call strLens
    ;-------------
    push 0
    lea ebx,[dwCnt]                         
    ;-------------
    push ebx                                ;--var for number of written symbols
    push eax                                ;--string length saved from lens function
    push esi                                ;--string address
    push dword ptr[dwHout]                  ;--handle
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

dwNum       equ [ebp-4]                         ;constants for not to forget, what we do
pBuff       equ [ebp+8]


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
    mov edi,dword ptr pBuff
    ;----------------
    push STD_INP_HANDLE
    call GetStdHandle@4
    ;----------------
    lea esi,dwNum
    ;----------------
    push 0
    push esi                                    ;--string length
    push MAX_SIZE
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

    cmp byte ptr[esi],0
    ;-------------
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
strLens proc
    push ebp
    mov ebp,esp
    push ebx
    push esi
    push edi
    ;------------
    mov esi,dword ptr[ebp+8]               
    ;------------
    xor ecx,ecx                         ; index = 0 in loop
    ;------------
    jmp _for                            ;--loop for
_in:

    inc ecx

_for:
    cmp byte ptr[esi+ecx],0
    jnz _in
    ;------------
    mov eax,ecx
    ;------------
    pop edi
    pop esi
    pop ebx
    mov esp,ebp
    pop ebp

    ret 4

strLens endp
;********************************************
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