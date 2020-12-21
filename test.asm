.586P
.model flat, stdcall
;---------------------
includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near
;---------------------



_DATA SEGMENT
    ExitCode    dd 0
    a           dd 100000
    b           dd 500000
    Res         dq 0
_DATA ENDS


_TEXT SEGMENT

START:
    
    push b
    
    push a
    call MulProc
    mov dword ptr Res,eax
    mov dword ptr Res+4,edx
    

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
    mov eax,dword ptr[ebp+8]
    mov ebx,dword ptr[ebp+12]
    mul ebx
;-----------------------
    
;-----------------------
    pop edi
    pop esi
    pop ebx
    leave
    ret 8                           
MulProc endp
;-------------------------
_TEXT ENDS
END START