include drive.inc
;------------------------------


.code

start:
	fn SetConsoleTitle,"Console Cursor demo"
	fn crt_system,"color 0A"
	;-----------------------------
	invoke MainProc
	
	fn crt_system,"pause"
	
	fn ExitProcess,0
	
MainProc proc uses ebx esi edi
	fn crt_printf,chr$("Formatting drive C:",13,10,13,10)	
	fn crt_puts,chr$("All your data will be erased",21h)
	;-------------------------------------
	invoke ShowProc
	;-------------------------------------
	mov word ptr[pos],0
	mov word ptr[pos+2],3
	;-------------------------------------
	invoke GetStdHandle,-11
	mov esi,[pos]
	invoke SetConsoleCursorPosition,eax,esi
	fn crt_puts,chr$("Relax, dude, it is only a joke",21h,21h,21h,20h,3ah,29h)
	ret
MainProc endp
;***********************************	
ShowProc proc uses ebx esi edi
	LOCAL hOut:DWORD
	
	xor ebx,ebx
	invoke GetStdHandle,-11
	mov dword ptr[hOut],eax
	;-----------------------------
	;xor esi,esi
	;mov esi,1
	;shl esi,16
	;-----------------------------
	mov word ptr[pos],0
	mov word ptr[pos+2],1
	@@Do:
		mov esi,[pos]
		invoke SetConsoleCursorPosition,hOut,esi
		;invoke wsprintf,addr szBuffer,addr szFrm,ebx,25h
		;fn crt_puts,offset szBuffer
		;-------------------------------
		fn crt_printf,addr szFrm,ebx,25h
		fn crt_puts,offset szBuffer
		fn Sleep,100
		
		inc ebx
		cmp ebx,100
		jbe @@Do
	
	ret
ShowProc endp
end start