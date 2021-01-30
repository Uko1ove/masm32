include test2.inc



.code

start:

    push offset szTitle
    call SetConsoleTitleA@4
;-------------------------
    push COLOR
    call setColor

    call main
;-------------------------
    push offset szExit
    call StdOut@4
;-------------------------
    call quit
;-------------------------
    push 0
    call ExitProcess@4
    
;**************************************

main proc                                   
    
        
    ret
main endp

;**********************************************

setColor proc
    push ebp
    mov ebp,esp
    push ebx
    push esi
    push edi
    ;-----------
    push STD_OUT_HANDLE
    call GetStdHandle@4
    ;-----------
    push dword ptr[ebp+8]
    push eax
    call SetConsoleTextAttribute@8
    ;-----------
    pop edi
    pop esi
    pop ebx
    mov esp,ebp
    pop ebp


    ret 4
setColor endp

;*************************************************

pBuff       equ [ebp+8]


cin proc                                        
    push ebp
    mov ebp,esp
;--------------------
    push MAX_SIZE
    push pBuff
    call StdIn@8
    ;----------------
    push ebx
    push esi
    push edi
    
    push pBuff
    call StripLF@4
;--------------------
    pop edi
    pop esi
    pop ebx
    mov esp,ebp
    pop ebp
    
    ret 4
cin endp

;*****************************************

lens proc                                   
    push ebp
    mov ebp,esp
    push ebx
    push esi
    push edi
    ;------------
    
    ;------------
    pop edi
    pop esi
    pop ebx
    mov esp,ebp
    pop ebp

    ret 4
lens endp

;*******************************************

small proc                                      ;--say hello and goodbye
    enter 0,0                   
    push ebx
    push esi
    push edi
;-----------------------
    
;-----------------------
    pop edi
    pop esi
    pop ebx
    leave
    ret                           
small endp
;-------------------------

;********************************************
quit proc
    push ebp
    mov ebp,esp
    ;----------
    add esp,-8
    ;----------
    push ebx
    push esi
    push edi
    ;------------------
    push STD_INP_HANDLE
    call GetStdHandle@4
    ;------------------
    mov ebx,eax
    ;------------------
    push 0
    push eax
    call SetConsoleMode@8
    ;------------------
    push 0
    lea esi,[ebp-8]
    push esi
    push 1                              ;Buffer size
    lea esi,[ebp-4]
    push esi
    push ebx
    call ReadConsoleA@20
    ;------------------

    pop edi
    pop esi
    pop ebx
    mov esp,ebp
    pop ebp

    ret 4

    
quit endp

;********************************************

end start