.586P
.model flat, stdcall
;---------------------
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
extern ExitProcess@4:near
extern GetStdHandle@4:near                     ;-function
extern CloseHandle@4:near
extern lstrlenA@4:near
extern WriteConsoleA@20:near
extern ReadConsoleA@20:near
extern wsprintfA:near                   ;- it has indefined num of parameters
;---------------------
_DATA SEGMENT
    ExitCode    dd 0
    hIn         dd 0                                ;var for input
    hOut        dd 0                                ;var for output
    szExit      db 13,10,"Press any key...",0       ;--string
    dwCnt       dd 0                                ;var for cout of symbols
    szBuffer    db 255 dup(0)
    szFrm       db "(2ac - bx - 12) / (cx + a) = %d",13,10,0    ;string with format
                                            ; format begins with "%". %d is format
                                            ; 13,10,0 new str, return carett
    szBuffer2   db 32 dup(0)              
        
_DATA ENDS


_TEXT SEGMENT

START:

    push -10                    ;--input stream
    call GetStdHandle@4
    mov hIn,eax                 ;--move handle from eax to var

    push -11                    ;--output stream
    call GetStdHandle@4
    mov hOut,eax
;------------------------
    push 4
    push -5
    push 16
    push 3
    call small
;------------------------
    push eax                    ;-after small proc the result is in eax
    lea eax,szFrm               ;-get address of format and move it to eax
    push eax                    ;--push the address of format to stack
    lea eax,szBuffer2           ;--get the address of buffer2
    push eax                    ;--push buffer2 address to stack
    call wsprintfA              ;--transform the result of "call" to string and
                                ;--write the result into buffer2
;-----------------------
    add esp,12                  ;--cleane stack, cause it's C function
;-----------------------
    push offset szBuffer2       ;--transfer the buffer2 address to function
    call lstrlenA@4             ;--get the string length and put it into eax
;-----------------------
    push 0
    push offset dwCnt           ;-var for number of written symbols
    push eax                    ;-string length
    push offset szBuffer2       ;--string. Address
    push hOut                   ;--handle output
    call WriteConsoleA@20
;------------------------
    lea eax,szExit              ;--new command lea. Puts address in register
    push eax
    call lstrlenA@4
;-------------------------
    push 0                      ;--push args from end to beginning <--NULL
    lea ebx,dwCnt 
    push ebx                    ;--variable to put count of symbols
    push eax                    ;--strlen--is written to eax-look before call
    push offset szExit          ;--string
    push [hOut]                 ;--handle--(in this case output)
    call WriteConsoleA@20
;-------------------------
    push 0                      ;--NULL
    lea ebx,dwCnt
    push ebx                    ;--var (addres where we put the count of symbols)
    push 255                    ;--buffer size
    lea eax,szBuffer
    push eax                    ;--var where buffer is written
    push[hIn]                   ;--handle (in this case input)
    call ReadConsoleA@20
;-------------------------
    
    push hIn
    call CloseHandle@4          ;--close and clean

    push hOut
    call CloseHandle@4
    
    
    push [ExitCode]
    call ExitProcess@4
;--------------------------
small proc                      
    enter 0,0                   
    push ebx
    push esi
    push edi
;-----------------------
    mov eax,dword ptr[ebp+8]
    add eax,eax                             ;2a
    imul dword ptr [ebp+16]                 ;2ac

    mov ecx,eax

    mov eax,dword ptr[ebp+12]
    cdq
    idiv dword ptr[ebp+20]                  ;b/x

    sub ecx,eax
    sub ecx,12

    mov eax,dword ptr[ebp+16]
    imul dword ptr[ebp+20]                  ;cx
    mov ebx,eax
    mov eax,dword ptr[ebp+8]
    add ebx,eax                             ;cx+a
;-----------------------
    mov eax,ecx
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