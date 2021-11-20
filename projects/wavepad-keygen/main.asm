.686P
.model flat,stdcall
;-----------------------------------
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\msvcrt.inc
include \masm32\include\masm32.inc

include \masm32\macros\macros.asm

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\msvcrt.lib
includelib  \masm32\lib\masm32.lib

extern ExitProcess@4:near
extern GetStdHandle@4:near
extern ReadConsoleA@20:near
extern WriteConsoleA@20:near

Main 			proto
;******************************************
.data
	inBuf				db	1 dup(?)
	ser_num				dd	8f2098h
	handle_in			dd	0
	buf1				db	7 dup(0)
	;-------------------------------------
	szAlpha				db	"abcdef",0
	szStr1				db	"mnbvaq",0
	szStr2				db	"cxzlbr",0
	szStr3				db	"kjhgct",0
	szStr4				db	"fdsady",0
	szStr5				db	"poiueu",0
	szStr6				db	"ytrefo",0
	szStr7				db	"wqalgx",0
	szStr8				db	"ksjdhv",0
	szStr9				db	"hfgbif",0
	szStr10				db	"qazwja",0
	szStr11				db	"sxedkf",0
	szStr12				db	"crfvlg",0
	szStr13				db	"tgbymh",0
	szStr14				db	"hnujni",0
	szStr15				db	"miklop",0
	szStr16				db	"plokpc",0
	;-------------------------------------
	table				dd	offset szStr1
						dd	offset szStr2
						dd	offset szStr3
						dd	offset szStr4
						dd	offset szStr5
						dd	offset szStr6
						dd	offset szStr7
						dd	offset szStr8
						dd	offset szStr9
						dd	offset szStr10
						dd	offset szStr11
						dd	offset szStr12
						dd	offset szStr13
						dd	offset szStr14
						dd	offset szStr15
						dd	offset szStr16
	;-------------------------------------
	buffer				db 16 dup(0)
	
	
	
	

;*******************************************
.code
start:

	push -10
	call GetStdHandle@4
	mov dword ptr[handle_in],eax

	call Main
	call c_cin
	invoke ExitProcess,0

Main proc
	LOCAL div100Result:DWORD
	LOCAL div9Result:DWORD
	LOCAL div3f:DWORD
	LOCAL div9Gen:DWORD

	fn szCopy,offset szAlpha,offset buffer
	;------------------------------
	mov eax,dword ptr[ser_num]
	xor edx,edx
	mov ecx,64h
	div ecx
	;------------------------------
	mov dword ptr[div100Result],eax
	;------------------------------
	mov ecx,9
	xor edx,edx
	div ecx
	;------------------------------
	mov dword ptr[div9Result],eax
	;------------------------------
	lea eax,dword ptr[buffer]
	push eax
	mov eax,dword ptr[table+edx*4]			;- addr of str
	push eax
	call Generate
	;------------------------------
	mov eax,dword ptr[div9Result]
	push eax
	push 7
	pop ecx
	xor edx,edx
	div ecx
	lea ecx,dword ptr[buffer]
	mov eax,dword ptr[table+edx*4+24h]
	push ecx
	push eax
	call Generate
	;--------------------------------
	mov eax,dword ptr[div100Result]
	push 3fh
	pop ecx
	xor edx,edx
	div ecx
	mov dword ptr[div3f],eax
	push 9
	pop ecx
	xor edx,edx
	div ecx
	lea ecx,dword ptr[buffer]
	mov dword ptr[div9Gen],eax
	push ecx
	mov eax,dword ptr[table+edx*4]
	push eax
	call Generate
	;-----------------------------------
	mov eax,dword ptr[div9Gen]
	push 7
	pop ecx
	xor edx,edx
	div ecx
	lea ecx,dword ptr[buffer]
	mov eax,dword ptr[table+edx*4+24h]
	push ecx
	push eax
	call Generate
	;-----------------------------------
	mov eax,dword ptr[div3f]
	push 3fh
	pop ecx
	xor edx,edx
	div ecx
	mov dword ptr[div3f],eax
	push 9
	pop ecx
	xor edx,edx
	div ecx
	mov dword ptr[div9Gen],eax
	lea ecx,dword ptr[buffer]
	mov eax,dword ptr[table+edx*4]
	push ecx
	push eax
	call Generate
	;------------------------------------
	mov eax,dword ptr[div9Gen]
	push 7
	pop ecx
	xor edx,edx
	div ecx
	lea ecx,dword ptr[buffer]
	mov eax,dword ptr[table+edx*4+24h]
	push ecx
	push eax
	call Generate
	;-------------------------------------
	mov eax,dword ptr[div3f]
	push 3fh
	pop ecx
	xor edx,edx
	div ecx
	mov dword ptr[div3f],eax
	push 9
	pop ecx
	xor edx,edx
	div ecx
	mov dword ptr[div9Gen],eax
	lea ecx,dword ptr[buffer]
	mov eax,dword ptr[table+edx*4]
	push ecx
	push eax
	call Generate
	;--------------------------------------
	mov eax,dword ptr[div9Gen]
	push 7
	pop ecx
	xor edx,edx
	div ecx
	lea ecx,dword ptr[buffer]
	mov eax,dword ptr[table+edx*4+24h]
	push ecx
	push eax
	call Generate
	;-------------------------------------
	mov eax,dword ptr[table+1ch]							;- not sure in this segment, check this if not
	lea ecx,dword ptr[buffer]								;- universal string for every number
	push ecx
	push eax
	call Generate
	;-------------------------------------
	mov eax,dword ptr[table+28h]							;- not sure in this segment, check this if not
	lea ecx,dword ptr[buffer]								;- universal string for every number
	push ecx
	push eax
	call Generate
	;-------------------------------------
	mov eax,0												;- in func it's movzx eax, word ptr[ebp+C], there is 0
	cdq
	push 9
	pop ecx
	idiv ecx
	mov edi,eax
	lea ecx,dword ptr[buffer]
	mov eax,dword ptr[table+edx*4]
	push ecx
	push eax
	call Generate
	;-------------------------------------
	mov eax,edi
	cdq
	push 7
	pop ecx
	idiv ecx
	lea ecx,dword ptr[buffer]
	mov eax,dword ptr[table+edx*4+24h]
	push ecx
	push eax
	call Generate
	;------------------------------------- ret 8 in original func ???
	
	
	
	print offset buffer
	call c_cin
	ret
Main endp
c_cin proc
	push ebp
	mov ebp,esp
	add esp,-4
	push ebx
	push edi
	push esi
	;--------------
	lea eax,dword ptr[inBuf]
	lea edi,dword ptr[esp]
	
	push 0
	push edi
	push 1
	push eax
	push dword ptr[handle_in]
	call ReadConsoleA@20
	;-------------
	pop edi
    pop esi
    pop ebx
    mov esp,ebp
    pop ebp
	
	ret
c_cin endp
Generate proc
	;- - ebp+8 - str[table+edx*4], ebp+C - buffer addr
	push ebp
	mov ebp,esp
	push ebx
	push edi
	push esi
	;------------------
	mov ebx,dword ptr[ebp+8]
	mov edi,dword ptr[ebp+0Ch]
	xor ecx,ecx
	push 1Ah
	pop esi
	;------------------
@@loop:
	movzx eax,byte ptr[edi+ecx]
	movzx edx,byte ptr[ebx+ecx]
	
	lea eax,dword ptr ds:[eax+edx-0C2h]
	cdq
	idiv esi
	add edx,61h
	mov byte ptr[edi+ecx],dl
	cmp ecx,5
	inc ecx
	jbe @@loop
	mov byte ptr[edi+ecx],0
	;--------------------
	pop esi
	pop edi
	pop ebx
	mov esp,ebp
	pop ebp
	
	ret 8
Generate endp

end start

