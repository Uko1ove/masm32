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
    mov eax,5                   ;--1st way
    mov ebx,-7
    imul ebx

    mov ebx,3                   ;--2nd way
    imul ebx,6

    mov ebx,500000              ;--3rd way
    imul eax,ebx,100000

    mov eax,55                  ;--4th way
    imul eax,dwA

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