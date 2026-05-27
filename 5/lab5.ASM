; ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜1 ˜˜ ˜˜˜˜˜˜˜˜˜˜
; ˜˜˜˜˜˜˜ ˜ 15
; ˜˜˜˜˜ "˜˜˜˜˜˜˜" ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜. ˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜
; ˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ (˜<M).
; ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜

format PE GUI 4.0   ;˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ Windows ˜ ˜˜˜˜˜˜ PE (Portable Executable)
entry start

include 'C:\Users\jar0s\msis\INCLUDE\WIN32A.INC'	; ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ win32a.inc (˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜ win32a.inc)

;include 'd:\Program files\fasm\INCLUDE\win32a.inc'
ID_ZAKUPL	   = 101    ;  ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜
ID_ISPORCH	   = 102    ;  ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜

section '.data' data readable writeable 	  ; ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜

  zakupl  rb 10     ; ˜˜˜˜˜˜˜˜˜˜˜˜˜ 10 ˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜
  isporch rb 10     ; ˜˜˜˜˜˜˜˜˜˜˜˜˜ 10 ˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜
  caption db '˜˜˜˜˜',0	   ;˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜˜
  message db '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜   %',0 ; ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜
  sys	dd 10  ; ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜
  sto	dd 100 ; ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ 100
section '.code' code readable executable    ; ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜

  start:
	xor	 eax,eax      ;˜˜˜=0
	invoke	DialogBoxParam,eax,37,HWND_DESKTOP,DialogProc,0  ;˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ DialogProc
	or	eax,eax       ;˜˜˜˜˜˜˜˜ eax=0
	jz	exit	      ;˜˜˜˜ ˜˜(˜˜˜˜˜˜ ˜˜˜˜˜˜ cancel), ˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ exit
	lea	esi, [zakupl] ;˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ esi ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜
	call	StrToInt      ;˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ EAX
	mov	ebx, eax      ;˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜ ˜˜˜˜˜˜˜˜ E˜X
	lea	esi, [isporch] ;˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ esi ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜
	call	StrToInt      ;˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ EAX
; ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜=100-(P*100)/M
	mul	[sto]	      ;EAX=P*100
	div	ebx	      ;EAX=(P*100)/M
	mov	ebx, eax      ;EBX=EAX
	mov	eax,100       ;EAX=100
	sub	eax, ebx      ;EAX=100-EBX
	lea	esi, [message+17] ;ESI=˜˜˜˜˜ ˜˜˜˜˜˜ message+17 (˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜)
	call  IntToStr	      ;˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ EAX ˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ESI
	invoke	MessageBox,HWND_DESKTOP,message,caption,MB_OK ;api ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜
  exit:
	invoke	ExitProcess,0  ; api ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜

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
;mov [sys],10 ; ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜
.l:
mul [sys]
;or edx,edx
;jnz .exit
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
jnc .err
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
	invoke	GetDlgItemText,[hwnddlg],ID_ZAKUPL,zakupl,3	; api ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ 3-˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ zakupl ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ID_ZAKUPL
	invoke	GetDlgItemText,[hwnddlg],ID_ISPORCH,isporch,3	; api ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ 3-˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ isporch ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ID_ISPORCH
topmost_ok:
	invoke	EndDialog,[hwnddlg],1  ; api ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ (˜˜˜˜˜˜˜˜ 1)
	jmp	processed
  wmclose:
	invoke	EndDialog,[hwnddlg],0  ; api ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ cancel (˜˜˜˜˜˜˜˜ 0)
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

  dialog demonstration,'Laboratornay rabota 1',70,70,190,100,WS_CAPTION 	      ; ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜
    dialogitem 'STATIC','Kol-vo zakuplennogo sahara:',1,10,10,170,8,WS_VISIBLE	      ; ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ "˜˜˜˜˜˜˜"
    dialogitem 'EDIT','',ID_ZAKUPL,110,9,15,13,WS_VISIBLE+WS_BORDER+WS_TABSTOP	     ;
    dialogitem 'STATIC','Kol-vo isporchenogo sahara:',1,10,40,170,8,WS_VISIBLE	      ;
    dialogitem 'EDIT','',ID_ISPORCH,110,39,15,13,WS_VISIBLE+WS_BORDER+WS_TABSTOP      ;
    dialogitem 'BUTTON','OK',IDOK,85,75,45,15,WS_VISIBLE+WS_TABSTOP+BS_DEFPUSHBUTTON  ;
    dialogitem 'BUTTON','C&ancel',IDCANCEL,135,75,45,15,WS_VISIBLE+WS_TABSTOP	      ;
  enddialog
