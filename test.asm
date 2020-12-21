.586P
.model flat, stdcall
;---------------------
includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near
;---------------------



_DATA SEGMENT
    ExitCode    dd 0
    a           db 127
    b           db 9
    
_DATA ENDS


_TEXT SEGMENT

START:
    movzx eax,a
    push eax
    call MulProc


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
    mov edx,0                   ;--clean edx, 'cause we'll have num > 2 byte
    movzx eax,byte ptr[ebp+8]
    mul al
    movzx ebx,byte ptr[ebp+8]
    mul bx                      ;--mult in bx - old byte. Result is in dx:ax
;-----------------------
    shl edx,16                  ;-- practical way to gather parts in var
    or eax,edx                  ; shl = shift left - moved 2 bytes result and +
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