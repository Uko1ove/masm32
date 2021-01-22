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
;----(2ac-b/x-12)/(cx+a)---a=3,b=16,c=-5,x=4
    push 4
    push -5
    push 16
    push 3
    
    
    call small


    
    
    push [ExitCode]
    call ExitProcess@4
;--------------------------
small proc                      
    enter 0,0                   
    push ebx
    push esi
    push edi
;-----------------------
    mov eax,dword ptr[ebp+12]           ;b
    cdq
    idiv dword ptr[ebp+20]              ;b/x
    mov ebx,eax

    mov eax,dword ptr[ebp+8]
    imul dword ptr[ebp+16]              ;a*c
    mov ecx,2
    imul ecx                            ;2*ac

    sub eax,ebx
    sub eax,12
    push eax
;-----------------------
    mov eax,dword ptr[ebp+16]           ;c
    imul dword ptr[ebp+20]              ;c*x
    add eax,dword ptr[ebp+8]            ;cx+a

    mov ebx,eax
    pop eax
    cdq
    idiv ebx
    
;-----------------------
    pop edi
    pop esi
    pop ebx
    leave
    ret 16                           
small endp
;-------------------------
_TEXT ENDS
END START