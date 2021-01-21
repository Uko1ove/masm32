.586P
.model flat, stdcall
;---------------------
includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near
;---------------------

;--- (2ac-b/x-12)/(cx+a)----

_DATA SEGMENT
    ExitCode    dd 0
    bA          db 3
    bB          db 16
    bC          db -5
    X           db 4
    r1          dd ?
    r2          dd ?
    
_DATA ENDS


_TEXT SEGMENT

START:
    mov eax,0
    mov ebx,0
    mov edx,0
    mov al,[bA]
    mov bl,[bC]
    imul bl
    movsx eax,ax
    imul eax,2
    push eax

    mov eax,0
    mov al,[bB]
    mov bl,[X]
    div bl
    movzx ebx,al
    pop eax
    sub eax,ebx
    sub eax,12
    mov dword ptr[r1],eax

    mov eax,0
    mov al,[bC]
    mov bl,[X]
    imul bl
    movsx eax,ax
    mov bl,[bA]
    add eax,ebx
    mov dword ptr[r2],eax

    mov eax,[r1]
    mov ebx,[r2]
    cdq
    idiv ebx

    push [ExitCode]
    call ExitProcess@4
;-------------------------
_TEXT ENDS
END START