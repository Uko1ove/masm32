.586P
.model flat, stdcall
;---------------------
includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near
;---------------------



_DATA SEGMENT
    ExitCode    dd 0
;--x=(a+b)/c--
    bA          db -55
    wB          dw -3145
    wC          dw 100
    dwX         dd 40
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
;------------------------
    movsx ax,byte ptr[bA]
    add ax,word ptr[wB]
    cwd
    idiv wC

    mov word ptr[dwX],ax
    mov word ptr[dwX+2],dx
        
    
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