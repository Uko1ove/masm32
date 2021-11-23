include \masm32\include\masm32rt.inc
include \masm32\include\msvcrt.inc

include \masm32\macros\macros.asm

includelib \masm\lib\msvcrt.lib
;--------------------------------------

MainProc		proto :DWORD
HandlerProc		proto :DWORD

COORDS struct
	
	x dw ?
	y dw ?
	
COORDS ends

uChars union
	
	unicodeChar			dw ?
	AsciiChar			db ?
	
uChars ends

KEY_EVENT_REC struct
	
	bKeyDown 			dd ?
	wRepeatCount		dw ?
	wVirtualKeyCode		dw ?
	wVirtualScanCode	dw ?
	uChar				uChars <>
	dwControlKeyState	dd ?
	
KEY_EVENT_REC ends

MOUSE_EVENT_REC struct
	
	dwMousePosition 	COORDS <>
	dwButtonState		dd ?
	dwControlKeyState	dd ?
	dwEventFlags		dd ?	
	
MOUSE_EVENT_REC ends

WINDOW_BUFFER_SIZE_REC struct
	
	dwSize 			COORDS <>
	
WINDOW_BUFFER_SIZE_REC ends

MENU_EVENT_REC struct
	
	dwCOmmandId		dd ?
	
MENU_EVENT_REC ends

FOCUS_EVENT_REC struct
	
	bsSetFocus		BYTE ?
	
FOCUS_EVENT_REC ends

Events UNION
	KeyEvent KEY_EVENT_REC <>
    MouseEvent MOUSE_EVENT_REC <>
    WindowBufferSizeEvent WINDOW_BUFFER_SIZE_REC <> 
    MenuEvent MENU_EVENT_REC <>
    FocusEvent FOCUS_EVENT_REC <>

Events ends



_INPUT_RECORD STRUCT
	
	EventType	word ?
				word 0			; dlya vyravnivaniya po 4 baitam
	Event		Events <>
_INPUT_RECORD ends





.const





.data?

ir			_INPUT_RECORD 1 dup (<>)
szBuffer	db 12 dup(?)


.data
szFrm		db "%i%c",13,10,0
szStr		db "CTRL+C Pressed",0
szStr1		db "CapsLock ON",0
szStr2		db "Left Alt Pressed",0
szStr3		db "Right Alt Pressed",0
szStr4		db "Left Ctrl Pressed",0
szStr5		db "Right Ctrl Pressed",0
szStr6		db "NumLock ON",0
szStr7		db "ScrollLock ON",0
szStr8		db "Shift Pressed",0
szEnhanced	db "Enhanced Key (virtual code) %d",13,10,0
szFunction	db "Function Key (virtual code) %d",13,10,0
szCode		db "Code %d",13,10,0
szSpace		db "Key Space Pressed",0
szChar		db "Key %c Pressed",13,10,0
