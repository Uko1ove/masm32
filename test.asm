.586P
.model flat, stdcall
;---------------------
includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near
;---------------------



_DATA SEGMENT
    ExitCode    dd 0
        
_DATA ENDS


_TEXT SEGMENT

START:
    mov ecx,11                      ;-- x = 11
    mov ebx,4                       ;-- b = 4
    mov eax,-2                      ;-- a = -2

    mov [esp+8],ecx
    mov [esp+4],ebx
    mov [esp],eax
    
    call small

;--SIZE--EXTENSION--OF--DATA

    mov eax,-1
    mov al,5                        ; <-- imitation of movzx, if positive
    mov ah,0

    mov al,-5                       ; <-- imitation if negative
    mov ah,0ffh

    mov eax,0                       ; <-- convert byte word
    mov al,-5
    cbw

    mov eax,0
    mov edx,0
    mov ax,-3654
    cwd

    
    
    push [ExitCode]
    call ExitProcess@4
;--------------------------
small proc                      
    enter 0,0                   
    push ebx
    push esi
    push edi
;-----------------------
    mov ecx,dword ptr[ebp+16]       ;x
    mov eax,dword ptr[ebp+12]       ;b
    imul ecx
    push eax

    mov eax,dword ptr[ebp+8]
    imul ecx
    imul ecx

    pop ebx
    sub eax,ebx
    add eax,10                  ;result1
;------------------------
    mov ebx,dword ptr[ebp+8]
    sub ecx,ebx                 ;result2
    cdq
    idiv ecx
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