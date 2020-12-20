.586P
.model flat, stdcall
;---------------------
includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near
;---------------------



_DATA SEGMENT
    ExitCode dd 0
    dwNum_1 dd 0
    dwNum_2 dd 0
    dwResult dd 0

_DATA ENDS


_TEXT SEGMENT

START:
    mov dwNum_1,5
    mov dwNum_2,10

    push dwNum_2
    push dwNum_1
    call AddProc
    mov dwResult,eax    ;---or mov dword ptr[dwResult],eax----

    mov eax,256
    mov ebx,-127        ;--mov args to function
    call SubProc

    push [ExitCode]
    call ExitProcess@4 
;--------------------------
AddProc proc
    push ebp                    ;--������ 2 ������� ����� �������� �� enter 0,0
    mov ebp,esp
    ;------------------
    sub esp, 8                  ;--�������� ����� � ����� ��� 2 ��������� ����������
    ;------------------
    mov dword ptr[ebp-4],0
                                ;--���������� ��������� ���������� � �� ���������
    mov dword ptr[ebp-8],0
    ;------------------
    
    push ebx
    push esi
    push edi
;--------------------------
    mov eax,dword ptr[ebp+8]
    mov ebx,dword ptr[ebp+0ch]
    add eax,ebx

;---------------------------
    pop edi
    pop esi
    pop ebx
    mov esp,ebp                  ;-- 2 ��������� ����� ret ����� ��������� �� leave
    pop ebp
    ret 8
AddProc endp
;--------------------------

SubProc proc
    sub eax,ebx                  ;--function operation with arguments
    neg eax
    not eax
    inc eax
    dec eax

    ret
SubProc endp

_TEXT ENDS
END START