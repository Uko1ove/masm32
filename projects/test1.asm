.586P
.model flat, stdcall
;---------------------
includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near
extern ReadConsoleA@20:near
extern WriteConsoleA@20:near
extern GetStdHandle@4:near
extern lstrlenA@4:near

;---------------------
_DATA SEGMENT
    ExitCode    dd 0
    szBufferR   db 255 dup(0)
    szBufferW   db 255 dup(0)
    hOut        dd 0
    hIn         dd 0
    szGreeting  db "Enter a string: ",13,10,0
    varOut      dd ?
    varIn       dd ?
    szFalse     db 13,10,"False",13,10,0
    szTrue      db 13,10,"True",13,10,0
    
_DATA ENDS

;---------------------

_TEXT SEGMENT

START:
    call main
    push ExitCode
    call ExitProcess@4

;**********************************
main proc
    push ebp
    mov ebp,esp
    push ebx
    push esi
    push edi
    ;-------------------
    push -11
    call GetStdHandle@4
    mov hOut,eax
    push 0
    lea eax,varOut
    push eax
    lea ebx,szGreeting
    push ebx
    call lstrlenA@4
    push eax
    push ebx
    push [hOut]
    call WriteConsoleA@20
    push 0
;-----------------------
    push -10
    call GetStdHandle@4
    mov hIn,eax
    push 0
    lea eax,varIn
    push eax
    push 255
    lea ebx,szBufferR
    push ebx
    push [hIn]
    call ReadConsoleA@20
;-----------------------
    push ebx
    call is_uppercase
    ;-------------------
    pop edi
    pop esi
    pop ebx
    mov esp,ebp
    pop ebp

    ret
main endp
;**********************************
is_uppercase proc
    push ebp
    mov ebp,esp
    push ebx
    push esi
    push edi
    ;------------
    push ebx
    call lstrlenA@4
    add eax,-2
    mov esi,dword ptr[ebp+8]
    mov byte ptr[esi+eax],0
    xor ecx,ecx
    
_while:
    mov al,byte ptr[esi]
    cmp al,0
    je _if_true
    cmp al,20h
    je _if_space
    cmp al,41h
    jl _if_false
    cmp al,5Ah
    jg _if_false
    inc esi
    inc ecx
    jmp _while


_if_space:
    inc esi
    inc ecx
    jmp _while

_if_false:
    push 0
    push offset varOut
    push offset szFalse
    call lstrlenA@4
    push eax
    push offset szFalse
    push [hOut]
    call WriteConsoleA@20
    jmp _while_end

_if_true:
    cmp ecx,0
    je _if_false
    push 0
    push offset varOut
    push offset szTrue
    call lstrlenA@4
    push eax
    push offset szTrue
    push [hOut]
    call WriteConsoleA@20
    jmp _while_end

    
    
_while_end:
    ;------------
    pop edi
    pop esi
    pop ebx
    mov esp,ebp
    pop ebp

    ret 4

is_uppercase endp
;**********************************

_TEXT ENDS
END START