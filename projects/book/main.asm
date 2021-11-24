include main.inc
;------------------------------


.code

start:
	
	fn SetConsoleTitle,"Phone book"
	fn crt_system,"color 0A"
	;-----------------------------
	invoke GetCommandLine
	invoke MainProc,eax
	
	fn crt_system,"pause"
	fn ExitProcess,0
	
MainProc proc uses ebx esi edi lpCommandLine:DWORD
	LOCAL hIn:DWORD
	LOCAL nRead:DWORD
	
	fn crt_puts,offset szStr1
	mov hIn,rv(GetStdHandle,-10)
	
@@Do:
	lea ebx,nRead
	or rv(ReadConsoleInput,hIn,offset ir,1,ebx),eax
	je @@Ret
	;-------------------
	movzx eax,word ptr[ir.EventType]
	
	; if not to check bKeyDown for 1, there will be registered both down & up
	.if eax == KEY_EVENT && ir.KeyEvent.bKeyDown == 1
		
		movzx eax,byte ptr[ir.KeyEvent.AsciiChar]
		.if al == 'q'|| al == 'Q'
			jmp @@Ret
		.elseif al == '1'
			fn crt_system,offset szClear
			fn crt_puts,offset szStr2
			fn crt_gets,offset ph.szName,sizeof ph.szName,addr nRead
			cmp byte ptr[eax],0
			jne @F
		@@Menu:
			fn crt_puts,offset szStr1
			jmp @@Do
		@@:
			fn crt_puts,offset szStr3
			fn crt_gets,offset ph.szPhone,sizeof ph.szPhone,addr nRead
			cmp byte ptr[eax],0
			jne @F
			jmp @@Menu
		@@:
			fn crt_puts,offset szDone
			jmp @@Menu
		.elseif al == '2'
			fn crt_system,offset szClear	
			movzx eax,byte ptr[ph.szName]
			.if al != 0
				invoke lstrcpy,offset szTempBuffer,offset szName
				;--------------------------------
				invoke lstrcat,offset szTempBuffer,offset ph.szName
				fn crt_puts,offset szTempBuffer
				
				invoke lstrcpy,offset szTempBuffer,offset szPhone
				;--------------------------------
				invoke lstrcat,offset szTempBuffer,offset ph.szPhone
				fn crt_puts,offset szTempBuffer
			.else
				fn crt_puts,offset szEmpty
			.endif
			jmp @@Menu
		.endif
		
	.endif
	
	
	
	
	
	
	jmp @@Do
@@Ret:
	ret
MainProc endp
;***********************************	

end start