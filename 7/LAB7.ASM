; ������ ���������� ������������ ������ �3 �� ����������
; ������� � 19
;      __       __
; (x1\/x2)^(x1\/x3)
;
format PE GUI 4.0   ;����������� ������ ���������� ������ ��� Windows � ������ PE (Portable Executable)
entry start

include 'C:\Users\jar0s\msis\INCLUDE\WIN32A.INC'	; ���������� ���������� win32a.inc (���������� ������� ������ ���� � ����� win32a.inc)
;include 'd:\Program files\fasm\INCLUDE\win32a.inc'
ID_x1		   = 101    ;  ���������� ��� ������ ����� x1
ID_x2		   = 102    ;  ���������� ��� ������ ����� x2
ID_x3		   = 103    ;  ���������� ��� ������ ����� x3

section '.data' data readable writeable 	  ; ���� �������� ������������ � ��������� ������

  x1  rb 2     ; ������������� 2 ����� ��� ����� �1
  x2  rb 2     ; ������������� 2 ����� ��� ����� �2
  x3  rb 2     ; ������������� 2 ����� ��� ����� �3
  caption_er db '������!',0	;��������� ��� ���� � �������
  message_er db '������� �� ������ ��������� x1, x2, x3',0 ; ������ ������ ������
  caption db '�����',0	    ;��������� ��� ���� � �������
  message db 'Y('	    ; ������ ������ ������
  x_1	  db  0,','	    ;��� ������ �1
  x_2	  db  0,','	    ;��� ������ �2
  x_3	  db  0,')='	    ;��� ������ �3
  y	  db  0,0	    ;1 ���� ��� ������ � 1 ����(0) �������� ����� ������ ��� ������
section '.code' code readable executable    ; ���� �������� ���� ���������

  start:
	xor	 eax,eax      ;���=0
	invoke	DialogBoxParam,eax,37,HWND_DESKTOP,DialogProc,0  ;��������� ���� ��������� ��������� DialogProc
	or	eax,eax       ;�������� eax=0
	jz	exit	      ;���� ��(������ ������ cancel), �� ������� � ����� exit
	mov	al,[x1]      ;al=���� ������� ����������� � ���������� �1
	mov	[x_1],al      ;��� ������ ������
	sub	al,30h	      ;al=al-30h(��� ������� '0'). �������� �������� ���������� �1(0 ��� 1)
	jz	ok_1	      ;xl=0
	cmp	al,1
	jz	ok_1	      ;x1=1
	jmp	error	      ;������� � ������ ������ � ������ ��������� �����
 ok_1:	mov	bl,[x2]       ;bl=���� ������� ����������� � ���������� �2
	mov	[x_2],bl      ;��� ������ ������
	sub	bl,30h	      ;bl=bl-30h(��� ������� '0'). �������� �������� ���������� �2(0 ��� 1)
	jz	ok_2	      ;x2=0
	cmp	bl,1
	jz	ok_2	      ;x2=1
	jmp	error	      ;������� � ������ ������ � ������ ��������� �����
 ok_2:	mov	ah,[x3]       ;ah=���� ������� ����������� � ���������� �3
	mov	[x_3],ah      ;��� ������ ������
	sub	ah,30h	      ;ah=ah-30h(��� ������� '0'). �������� �������� ���������� �3(0 ��� 1)
	jz	ok_3	      ;x3=0
	cmp	al,1
	jz	ok_3	      ;x3=1
	jmp	error	      ;������� � ������ ������ � ������ ��������� �����
 ok_3:
 ;al=x1, bl=x2, ah=x3
 ;���������� ���������� ������� Y �� �������� � ������� �������
	mov	bh,al	      ;bh=al
	not	bl	      ;�������� x2
	sub	bl,11111110b  ;������� � 2 �� 7 ���� �������� bl
	or	al,bl	      ;al=x1\/not x2
	not	ah	      ;�������� x3
	sub	ah,11111110b  ;������� � 2 �� 7 ���� �������� ah
	or	bh,ah	      ;bh=x1\/not x3
	and	al,bh	      ;al=(x1\/not x2)^(x1\/not x3)
	add	al,30h	      ;������� � ascii �������� �������� al
	mov	[y],al	      ;��� ������ ���������� y
	invoke	MessageBox,HWND_DESKTOP,message,caption,MB_OK ;api ������� ������ ��������� �� ����� (����� ������)
	jmp	exit
 error: invoke	MessageBox,HWND_DESKTOP,message_er,caption_er,MB_OK ;api ������� ������ ��������� �� ����� (����� ��������� � ������)
	jmp	exit

  exit:
	invoke	ExitProcess,0  ; api ������� ��� ���������� ���������

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
	invoke	GetDlgItemText,[hwnddlg],ID_x1,x1,2   ; api ������� ��������� 2-� ���� ������ � ���������� x1 �� ������� �������� ������������� ID_x1
	invoke	GetDlgItemText,[hwnddlg],ID_x2,x2,2   ; api ������� ��������� 2-� ���� ������ � ���������� x2 �� ������� �������� ������������� ID_x2
	invoke	GetDlgItemText,[hwnddlg],ID_x3,x3,2   ; api ������� ��������� 2-� ���� ������ � ���������� x3 �� ������� �������� ������������� ID_x3
topmost_ok:
	invoke	EndDialog,[hwnddlg],1  ; api ������� ���������� ������� � ���������� ����������� �� ����� (�������� 1)
	jmp	processed
  wmclose:
	invoke	EndDialog,[hwnddlg],0  ; api ������� ���������� ���������� ������� �������� �� ������ cancel (�������� 0)
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

  dialog demonstration,'Laboratornay rabota 3',70,70,120,65,WS_CAPTION		     ; ������ ��������� � ������� ���� ����������
    dialogitem 'STATIC','x1:',1,10,10,170,8,WS_VISIBLE	      ; ������ ��������� ������ �� ����������, ������������� ������� "�������"
    dialogitem 'EDIT','',ID_x1,20,9,10,13,WS_VISIBLE+WS_BORDER+WS_TABSTOP	;
    dialogitem 'STATIC','x2:',1,10,20,170,8,WS_VISIBLE	      ;
    dialogitem 'EDIT','',ID_x2,20,19,10,13,WS_VISIBLE+WS_BORDER+WS_TABSTOP	;
    dialogitem 'STATIC','x3:',1,10,30,170,8,WS_VISIBLE	      ;
    dialogitem 'EDIT','',ID_x3,20,29,10,13,WS_VISIBLE+WS_BORDER+WS_TABSTOP	;
    dialogitem 'BUTTON','OK',IDOK,15,45,45,15,WS_VISIBLE+WS_TABSTOP+BS_DEFPUSHBUTTON  ;
    dialogitem 'BUTTON','C&ancel',IDCANCEL,65,45,45,15,WS_VISIBLE+WS_TABSTOP	     ;
  enddialog
