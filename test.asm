.586P
.model flat, stdcall
;---------------------
includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near
;---------------------



_DATA SEGMENT
    ExitCode    dd 0
    dwA         dd 40
    
_DATA ENDS


_TEXT SEGMENT

START:
    mov ebx,5
    mov eax,3
    mov [esp+4],ebx            ; <- give parametr to address esp+4
    mov [esp],eax              ; <- it's one more way to give parametr to function
    call small

    push [ExitCode]
    call ExitProcess@4
;--------------------------
small proc                      ;-- example a^2+b^2
    enter 0,0                   ;-- = push ebp  mov ebp,esp
    push ebx
    push esi
    push edi
;-----------------------
    mov eax,[ebp+8]
    imul eax                    ;-- a*a
    push eax                    ;-- hide result in stack

    mov eax,[ebp+12]
    imul eax                    ;-- b*b

    pop ebx                     ;-- take from stack first result
    add eax,ebx                 ;-- a^2 + b^2
        
;-----------------------
    pop edi
    pop esi
    pop ebx
    leave
    ret 8                           
small endp
;-------------------------
_TEXT ENDS
END START