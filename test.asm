.586P
.model flat, stdcall
;---------------------
includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near
;---------------------



_DATA SEGMENT
    ExitCode    dd 0
    dwA         dd -2
    dwB         dd 4
    dwX         dd 11
    
_DATA ENDS


_TEXT SEGMENT

START:
    push dwX
    push dwB
    push dwA
    call small
    
    push [ExitCode]
    call ExitProcess@4
;--------------------------
small proc                      
    enter 0,0                   
    push ebx
    push esi
    push edi
    sub esp,8
;-----------------------
    mov edx,0
    mov ebx,dword ptr[ebp+16]
    mov eax,dword ptr[ebp+12]
    mul ebx                            ; <-- b*x
    push eax
    
    mov eax,ebx
    mul eax
    mov ebx,dword ptr[ebp+8]
    imul ebx

    pop ebx
    sub eax,ebx
    add eax,10
    mov dword ptr[ebp-20],eax

    mov eax,dword ptr[ebp+16]
    mov ebx,dword ptr[ebp+8]
    sub eax,ebx
    mov dword ptr[ebp-16],eax

    pop eax
    pop ebx
    cdq
    idiv ebx
;-----------------------
    pop edi
    pop esi
    pop ebx
    leave
    ret 12                           
small endp
;-------------------------
_TEXT ENDS
END START