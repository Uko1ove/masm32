.586P
.model flat, stdcall
;---------------------
includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near
;---------------------



_DATA SEGMENT
    ExitCode    dd 0
    a           db 60
    b           db 9
    
_DATA ENDS


_TEXT SEGMENT

START:
    mov eax,0
    mov ebx,0
    mov al,a
    mov bl,b
    push ebx
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
;-----------------------
    mov eax,0                   ;-- mutl and '/' use only eax
    mov al,byte ptr[ebp+8]      ;-- move to junior byte eax
    mov bl,byte ptr[ebp+12]     ;-- move to junior byte ebx
    mul bl                      ;-- multiply al*bl

;-----------------------
    pop edi
    pop esi
    pop ebx
    ret 8
    
MulProc endp
;-------------------------
_TEXT ENDS
END START