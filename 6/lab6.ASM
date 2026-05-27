; ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜2 ˜˜ ˜˜˜˜˜˜˜˜˜˜
; ˜˜˜˜˜˜˜ ˜ 15
;          4*x^2+5,      x>4
;   f(x)=|
;          5*x+4*x^2+1,   x<=4

format PE GUI 4.0   ;˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ Windows ˜ ˜˜˜˜˜˜ PE (Portable Executable)
entry start
include 'C:\Users\jar0s\msis\INCLUDE\WIN32A.INC'	; ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ win32a.inc (˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜ win32a.inc)
;include 'D:\Program files\FASM\INCLUDE\win32a.inc'

ID_x	      = 101    ;  ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ x

section '.data' data readable writeable 	  ; ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜

  x  rb 10     ; ˜˜˜˜˜˜˜˜˜˜˜˜˜ 10 ˜˜˜˜ ˜˜˜ ˜˜˜˜˜ x
  caption db '˜˜˜˜˜',0	   ;˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜˜
  error   db '˜˜˜˜˜˜ ˜˜˜˜˜!!!',0
  message db 'F(x)=          ',0 ; ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜
  sys	dd 10  ; ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜
  chislo dd ?
section '.code' code readable executable    ; ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜

  start:
	xor	 eax,eax					 ;˜˜˜=0
	invoke	DialogBoxParam,eax,37,HWND_DESKTOP,DialogProc,0  ;˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ DialogProc
	or	eax,eax       ;˜˜˜˜˜˜˜˜ eax=0
	jz	exit	      ;˜˜˜˜ ˜˜(˜˜˜˜˜˜ ˜˜˜˜˜˜ cancel), ˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ exit
	lea	esi, [x]      ;˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ esi ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ x
	call	StrToInt      ;˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ x ˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ EAX
	or	ecx,ecx       ;ecx=0?
	jnz	norm	      ;˜˜˜˜ ˜˜˜, ˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜
	invoke	MessageBox,HWND_DESKTOP,error,caption,MB_OK ;˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜
	jmp	exit
; ˜˜˜˜˜˜˜˜ ˜˜˜˜˜
 norm:	cmp	 eax,4
	ja	 var1  ; ˜˜˜˜ EAX>4 ˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ var1
	mov	 ebx, eax ;ebx=eax
	mov	 [chislo],5
	mul	 [chislo] ;EAX=EAX*5
	mov	 ecx, eax ;ecx=eax
	mov	 eax, ebx ;eax=ebx
	mul	 eax ; eax=eax*eax
	mov	 [chislo],4
	mul	 [chislo] ;EAX=EAX*4
	add	 ecx, eax ;ecx=ecx+eax
	add	 ecx, 1
	mov	 eax, ecx
	jmp	 vivod
var1:	mul	 eax ; eax=eax*eax
	mov	 [chislo],4
	mul	 [chislo] ;EAX=EAX*4
	add	 eax,5	; EAX=EAX+5
vivod:	lea	esi, [message+6] ;ESI=˜˜˜˜˜ ˜˜˜˜˜˜ message+6 (˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜)
	call  IntToStr
	invoke	MessageBox,HWND_DESKTOP,message,caption,MB_OK
  exit:
	invoke	ExitProcess,0

proc IntToStr; eax - ˜˜˜˜˜, esi - ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜

pushad
mov ebx,10
xor ecx,ecx
;------ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜, ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜
start1:
cmp eax,0
je end1
xor edx,edx
div ebx
or dl,30h
push edx
inc ecx
jmp start1
end1:
;------ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜
start3:
cmp ecx,0
je end3
pop eax
mov [esi],al
inc esi
dec ecx
jmp start3
end3:
popad
ret
endp
;********************************************************************************************
proc StrToInt ;(esi-˜˜˜˜˜˜):eax-˜˜˜˜˜,esi-˜˜˜˜˜˜˜ ˜˜˜˜˜˜,ecx-˜˜˜˜˜˜˜˜˜ ˜˜˜˜ enter
xor eax,eax ; ˜˜˜˜˜˜˜˜˜
xor ecx,ecx ; ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜
.l:
mul [sys]
; ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜
movzx edx,byte [esi]
sub dl,30h
jc .err
cmp dl,9h
; ˜˜˜˜ dl ˜˜˜˜˜˜ 9h, ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜
jle .next
sub dl,7h
.next:
cmp dl,byte [sys]
jnc .errs
add eax,edx
jc .err2
; ˜˜˜˜˜˜˜˜˜˜˜ ecx (˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜)
inc ecx
; ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜
inc esi
; ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜
jmp .l
.err2:
sub eax,edx
.err:
xor edx,edx
jmp .exit
.errs:
xor ecx,ecx
ret
.exit:
div [sys]
ret
endp
proc DialogProc,hwnddlg,msg,wparam,lparam
	push	ebx esi edi
	cmp	[msg],WM_INITDIALOG
	je	processed
	cmp	[msg],WM_COMMAND
	je	wmcommand
	cmp	[msg],WM_CLOSE
	je	wmclose
	xor	eax,eax
	jmp	finish
 wmcommand:
	cmp	[wparam],BN_CLICKED shl 16 + IDCANCEL
	je	wmclose
	cmp	[wparam],BN_CLICKED shl 16 + IDOK
	jne	processed
	invoke	GetDlgItemText,[hwnddlg],ID_x,x,10
topmost_ok:
	invoke	EndDialog,[hwnddlg],1
	jmp	processed
  wmclose:
	invoke	EndDialog,[hwnddlg],0
  processed:
	mov	eax,1
  finish:
	pop	edi esi ebx
	ret
endp

section '.idata' import data readable writeable

  library kernel,'KERNEL32.DLL',\
	  user,'USER32.DLL'

  import kernel,\
	 GetModuleHandle,'GetModuleHandleA',\
	 ExitProcess,'ExitProcess'

  import user,\
	 DialogBoxParam,'DialogBoxParamA',\
	 CheckRadioButton,'CheckRadioButton',\
	 GetDlgItemText,'GetDlgItemTextA',\
	 IsDlgButtonChecked,'IsDlgButtonChecked',\
	 MessageBox,'MessageBoxA',\
	 EndDialog,'EndDialog'

section '.rsrc' resource data readable

  directory RT_DIALOG,dialogs

  resource dialogs,\
	  37,LANG_RUSSIAN,demonstration    \

  dialog demonstration,'Laboratornay rabota 2',100,100,110,60,WS_CAPTION ; ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜
    dialogitem 'STATIC','X=',1,10,10,70,8,WS_VISIBLE	    ; ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ "˜˜˜˜˜˜˜"
    dialogitem 'EDIT','',ID_x,22,8,15,13,WS_VISIBLE+WS_BORDER+WS_TABSTOP       ;
    dialogitem 'BUTTON','OK',IDOK,10,35,45,15,WS_VISIBLE+WS_TABSTOP+BS_DEFPUSHBUTTON  ;
    dialogitem 'BUTTON','C&ancel',IDCANCEL,60,35,45,15,WS_VISIBLE+WS_TABSTOP	     ;
  enddialog
