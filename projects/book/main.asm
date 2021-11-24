include main.inc
;------------------------------


.code

start:
	
	fn SetConsoleTitle,"Input recotd demo"
	fn crt_system,"color 0A"
	;-----------------------------
	invoke GetCommandLine
	invoke MainProc,eax
	
	fn crt_system,"pause"
	fn ExitProcess,0
	
MainProc proc uses ebx esi edi lpCommandLine:DWORD
	LOCAL hIn:DWORD
	LOCAL nRead:DWORD
	
	fn GetStdHandle,-10
	mov hIn,eax
	
@@Do:
	
	
	
	
	
	
	
	
	
	jmp @@Do
@@Ret:
	ret
MainProc endp
;***********************************	

end start