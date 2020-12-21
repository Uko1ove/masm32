.586P
.model flat, stdcall
;---------------------
includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near
;---------------------



_DATA SEGMENT
    ExitCode    dd 0
    a           dw 256
    b           dw 60000
    Res         dd 0
_DATA ENDS


_TEXT SEGMENT

START:
    movzx ebx,b
    push ebx
    movzx eax,a
    push eax
    call MulProc
    mov word ptr Res,ax
    mov word ptr Res+2,dx
    mov eax,Res

    push [ExitCode]
    call ExitProcess@4 
;--------------------------
MulProc proc
    enter 0,0                   ;-- = push ebp  mov ebp,esp
    push ebx
    push esi
    push edi
    sub esp,4                   ;-- local var for result
;-----------------------
    mov edx,0
    movzx eax,word ptr[ebp+8]
    mov bx,word ptr[ebp+12]
    mul bx
;-----------------------
    
;-----------------------
    pop edi
    pop esi
    pop ebx
    leave
    ret 4                       ;-- we had only 1 argyment. = 4 byte
    
MulProc endp
;-------------------------
_TEXT ENDS
END START