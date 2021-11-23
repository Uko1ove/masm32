include main.inc
;------------------------------


.code

start:
	invoke SetConsoleCtrlHandler,offset HandlerProc,1
	fn SetConsoleTitle,"Input recotd demo"
	fn crt_system,"color 0A"
	;-----------------------------
	invoke GetCommandLine
	invoke MainProc,eax
	
	fn crt_system,"pause"
	invoke SetConsoleCtrlHandler,offset HandlerProc,0
	fn ExitProcess,0
	
MainProc proc uses ebx esi edi lpCommandLine:DWORD
	LOCAL hIn:DWORD
	LOCAL nRead:DWORD
	
	fn GetStdHandle,-10
	mov hIn,eax
	
@@Do:
	invoke ReadConsoleInput,hIn,offset ir,1,addr nRead
	or eax,eax
	je @@Ret	
	;--------------------
	movzx eax,word ptr[ir.EventType]
	cmp ax,KEY_EVENT
	jne @@Mouse
	;--------------------
	cmp dword ptr[ir.Event.KeyEvent.bKeyDown],1
	jne @@Do
	;--------------------
	cmp dword ptr[ir.Event.KeyEvent.dwControlKeyState],CAPSLOCK_ON
	; jump forward on first mark @@:
	jne @F
	fn crt_puts,offset szStr1
	jmp @@Key
	;--------------------------
@@:	
	cmp dword ptr[ir.Event.KeyEvent.dwControlKeyState],ENHANCED_KEY
	jne @F
	movzx eax,word ptr[ir.Event.KeyEvent.wVirtualKeyCode]
	fn crt_printf,offset szEnhanced,eax
	jmp @@Do
	;----------------------------
@@:
	cmp dword ptr[ir.Event.KeyEvent.dwControlKeyState],LEFT_ALT_PRESSED
	jne @F
	fn crt_puts,offset szStr2
	jmp @@Key
	;-----------------------------
@@:
	cmp dword ptr[ir.Event.KeyEvent.dwControlKeyState],RIGHT_ALT_PRESSED
	jne @F
	fn crt_puts,offset szStr3
	jmp @@Key
	;-----------------------------
@@:
	cmp dword ptr[ir.Event.KeyEvent.dwControlKeyState],LEFT_CTRL_PRESSED
	jne @F
	fn crt_puts,offset szStr4
	jmp @@Key
	;-----------------------------
@@:
	cmp dword ptr[ir.Event.KeyEvent.dwControlKeyState],RIGHT_CTRL_PRESSED
	jne @F
	fn crt_puts,offset szStr5
	jmp @@Key
	;----------------------------
@@:
	cmp dword ptr[ir.Event.KeyEvent.dwControlKeyState],NUMLOCK_ON
	jne @F
	fn crt_puts,offset szStr6
	jmp @@Key
	;----------------------------
@@:
	cmp dword ptr[ir.Event.KeyEvent.dwControlKeyState],SCROLLLOCK_ON
	jne @F
	fn crt_puts,offset szStr7
	jmp @@Key
	;----------------------------
@@:
	cmp dword ptr[ir.Event.KeyEvent.dwControlKeyState],SHIFT_PRESSED
	jne @@Key
	fn crt_puts,offset szStr8
	;----------------------------


@@Key:
	movzx eax,byte ptr[ir.Event.KeyEvent.uChar.AsciiChar]
	cmp al,20h
	jb @F
	
	.if eax == 32
		fn crt_puts,offset szSpace
		jmp @@Mouse
	.endif
	
	fn crt_printf,offset szChar,eax
	jmp @@Mouse
@@:
	or al,al
	jne @F
	movzx eax,word ptr[ir.Event.KeyEvent.wVirtualKeyCode]
	fn crt_printf,offset szFunction,eax
	jmp @@Mouse

@@:
	fn crt_printf,offset szCode,eax
	
@@Mouse:	
	;------------------
	jmp @@Do
@@Ret:
	ret
MainProc endp
;***********************************	
HandlerProc proc uses ebx esi edi dwCtrlType:DWORD
	
	mov eax,dwCtrlType
	
	;.if eax == CTRL_C_EVENT
	;	fn crt_puts,"CTRL+C Pressed"
		;----------------------------
	;	@@Close:
	;	fn Sleep,2000
	;	fn ExitProcess,0	
		;----------------------------
	;	mov eax,1
	;	ret
	;.elseif eax == CTRL_BREAK_EVENT
	;	fn crt_puts,"CTRL+Break Pressed"
	;	jmp @@Close
	;.elseif eax == CTRL_CLOSE_EVENT
	;	fn crt_puts,"Closing console"
	;	jmp @@Close
	;.elseif eax == CTRL_LOGOFF_EVENT
	;	fn crt_puts,"Closing console"
	;	jmp @@Close
	;.elseif eax == CTRL_SHUTDOWN_EVENT
	;	fn crt_puts,"Closing console"
	;	jmp @@Close
	;.endif
	
	switch eax
		case CTRL_C_EVENT
			fn crt_puts,"Ctrl+C Pressed"
		@@Close:
			fn Sleep,2000
			fn ExitProcess,0
			mov eax,1
			ret
		
		case CTRL_BREAK_EVENT
			fn crt_puts,"CtrL+Break Pressed"
			jmp @@Close
		
		case CTRL_CLOSE_EVENT
			fn crt_puts,"Closing Console"
			jmp @@Close
		
		case CTRL_LOGOFF_EVENT
			fn crt_puts,"Closing Console"
			jmp @@Close
		
		case CTRL_SHUTDOWN_EVENT
			fn crt_puts,"Closing Console"
			jmp @@Close
		
		default
			xor eax,eax
			ret
		
	endsw
	
	xor eax,eax
	
	ret
HandlerProc endp

end start