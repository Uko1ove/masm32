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
    mov eax,0
    mov edx,0
    movsx ax,byte ptr[bA]
    add ax,word ptr[wB]
    cwd
    idiv wC

    
    mov word ptr[dwX],ax
    mov word ptr[dwX+2],dx
        
    
    push [ExitCode]
    call ExitProcess@4
;--------------------------

;-------------------------
_TEXT ENDS
END START