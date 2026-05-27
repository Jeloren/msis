format PE GUI 4.0
entry start

include 'C:\Users\jar0s\msis\INCLUDE\WIN32A.INC'

ID_A       = 101    
ID_B       = 102    
ID_C       = 103    
ID_D       = 104    

section '.data' data readable writeable

  str_a   rb 10
  str_b   rb 10
  str_c   rb 10
  str_d   rb 10
  
  var_a   dd 0
  var_b   dd 0
  var_c   dd 0
  var_d   dd 0

  caption db 'Rezultat',0
  message db 'Otvet: y =           ',0
  
  sys     dd 10
  error_msg db 'Oshibka: delenie na nol!',0

section '.code' code readable executable

  start:
    xor eax, eax
    invoke DialogBoxParam, eax, 37, HWND_DESKTOP, DialogProc, 0
    or eax, eax
    jz exit

    lea esi, [str_a]
    call StrToInt
    mov [var_a], eax

    lea esi, [str_b]  
    call StrToInt     
    mov [var_b], eax  

    lea esi, [str_c]  
    call StrToInt     
    mov [var_c], eax  

    lea esi, [str_d]  
    call StrToInt     
    mov [var_d], eax  

    mov eax, [var_a]
    mul [var_b]
    mov ebx, eax

    mov eax, [var_c]
    xor edx, edx
    ;-----------
    cmp [var_d], 0
    je error_zero
    ;-----------
    div [var_d]

    sub ebx, eax

    add ebx, [var_a]

    mov eax, ebx
    
    lea esi, [message+11] 
    call IntToStr

    invoke MessageBox, HWND_DESKTOP, message, caption, MB_OK 
    jmp exit

  error_zero:
    invoke MessageBox, HWND_DESKTOP, error_msg, caption, 10h 

  exit:
    invoke ExitProcess, 0

proc IntToStr
    pushad
    mov ebx, 10
    xor ecx, ecx
  start1:
    cmp eax, 0
    je end1
    xor edx, edx
    div ebx
    or dl, 30h
    push edx
    inc ecx
    jmp start1
  end1:
  start3:
    cmp ecx, 0
    je end3
    pop eax
    mov [esi], al
    inc esi
    dec ecx
    jmp start3
  end3:
    popad
    ret
endp

proc StrToInt
    xor eax, eax 
    xor ecx, ecx 
  .l:
    mul [sys]
    movzx edx, byte [esi]
    sub dl, 30h
    jc .err
    cmp dl, 9h
    jle .next
    sub dl, 7h
  .next:
    cmp dl, byte [sys]
    jnc .err
    add eax, edx
    jc .err2
    inc ecx
    inc esi
    jmp .l
  .err2:
    sub eax, edx
  .err:
    xor edx, edx
  .exit:
    div [sys]
    ret
endp

proc DialogProc, hwnddlg, msg, wparam, lparam
    push ebx esi edi
    cmp [msg], WM_INITDIALOG
    je processed
    cmp [msg], WM_COMMAND
    je wmcommand
    cmp [msg], WM_CLOSE
    je wmclose
    xor eax, eax
    jmp finish
  wmcommand:
    cmp [wparam], BN_CLICKED shl 16 + IDCANCEL
    je wmclose
    cmp [wparam], BN_CLICKED shl 16 + IDOK
    jne processed
    
    invoke GetDlgItemText, [hwnddlg], ID_A, str_a, 10   
    invoke GetDlgItemText, [hwnddlg], ID_B, str_b, 10   
    invoke GetDlgItemText, [hwnddlg], ID_C, str_c, 10   
    invoke GetDlgItemText, [hwnddlg], ID_D, str_d, 10   
  topmost_ok:
    invoke EndDialog, [hwnddlg], 1
    jmp processed
  wmclose:
    invoke EndDialog, [hwnddlg], 0
  processed:
    mov eax, 1
  finish:
    pop edi esi ebx
    ret
endp

section '.idata' import data readable writeable
  library kernel,'KERNEL32.DLL', user,'USER32.DLL'

  import kernel,\
     GetModuleHandle,'GetModuleHandleA',\
     ExitProcess,'ExitProcess'

  import user,\
     DialogBoxParam,'DialogBoxParamA',\
     GetDlgItemText,'GetDlgItemTextA',\
     MessageBox,'MessageBoxA',\
     EndDialog,'EndDialog'

section '.rsrc' resource data readable
  directory RT_DIALOG, dialogs

  resource dialogs, 37, LANG_RUSSIAN, demonstration    

  dialog demonstration,'Lab 5 - Variant 19',70,70,180,140,WS_CAPTION  
    
    dialogitem 'STATIC','A:',1,10,10,20,13,WS_VISIBLE      
    dialogitem 'EDIT','',ID_A,30,9,120,13,WS_VISIBLE+WS_BORDER+WS_TABSTOP     
    
    dialogitem 'STATIC','B:',1,10,30,20,13,WS_VISIBLE      
    dialogitem 'EDIT','',ID_B,30,29,120,13,WS_VISIBLE+WS_BORDER+WS_TABSTOP      
    
    dialogitem 'STATIC','C:',1,10,50,20,13,WS_VISIBLE      
    dialogitem 'EDIT','',ID_C,30,49,120,13,WS_VISIBLE+WS_BORDER+WS_TABSTOP  

    dialogitem 'STATIC','D:',1,10,70,20,13,WS_VISIBLE      
    dialogitem 'EDIT','',ID_D,30,69,120,13,WS_VISIBLE+WS_BORDER+WS_TABSTOP  

    dialogitem 'BUTTON','OK',IDOK,40,100,45,15,WS_VISIBLE+WS_TABSTOP+BS_DEFPUSHBUTTON  
    dialogitem 'BUTTON','Cancel',IDCANCEL,90,100,45,15,WS_VISIBLE+WS_TABSTOP        
  enddialog