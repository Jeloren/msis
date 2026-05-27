format PE GUI 4.0   
entry start

include 'C:\Users\jar0s\msis\INCLUDE\WIN32A.INC'

ID_x1 = 101
ID_x2 = 102
ID_x3 = 103

section '.data' data readable writeable

  x1  rb 2     
  x2  rb 2     
  x3  rb 2     
  
  caption_er db 'Oshibka!',0 
  message_er db 'Vvedite tolko 0 ili 1 dlya x1, x2, x3',0 
  caption    db 'Otvet',0 
  
  message db 'Y('       
  x_1     db  0,','     
  x_2     db  0,','     
  x_3     db  0,')='    
  y       db  0,0       

section '.code' code readable executable

  start:
    xor eax, eax
    invoke DialogBoxParam, eax, 37, HWND_DESKTOP, DialogProc, 0
    or eax, eax
    jz exit

    mov al, [x1]
    mov [x_1], al       
    sub al, 30h         
    jz ok_1
    cmp al, 1
    jz ok_1
    jmp error           

 ok_1:
    mov bl, [x2]
    mov [x_2], bl
    sub bl, 30h
    jz ok_2
    cmp bl, 1
    jz ok_2
    jmp error

 ok_2:
    mov ah, [x3]
    mov [x_3], ah
    sub ah, 30h
    jz ok_3
    cmp ah, 1
    jz ok_3
    jmp error

 ok_3:
    ; Y = (NOT X1 AND X2) OR NOT(NOT X1 AND X3)
    
    ; 1. NOT X1
    mov dl, al      ; Kopiruem X1 v DL
    not dl          
    and dl, 1       ; DL = NOT X1 

    ; 2. NOT X1 AND X2 (Levaya chast)
    mov cl, dl      ; CL = NOT X1
    and cl, bl      ; CL = (NOT X1) AND X2

    ; 3. NOT X1 AND X3 
    mov ch, dl      ; CH = NOT X1
    and ch, ah      ; CH = (NOT X1) AND X3

    ; 4. NOT (NOT X1 AND X3) 
    not ch          
    and ch, 1       ; CH = NOT(NOT X1 AND X3)

    ; 5. OR 
    or cl, ch       ; CL = CL OR CH 

    ; --- Вывод результата ---
    mov al, cl      
    add al, 30h     
    mov [y], al     
    
    invoke MessageBox, HWND_DESKTOP, message, caption, MB_OK
    jmp exit

 error: 
    invoke MessageBox, HWND_DESKTOP, message_er, caption_er, MB_OK
    jmp exit

 exit:
    invoke ExitProcess, 0

; --------------------------------------------------------------------------
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
    
    invoke GetDlgItemText, [hwnddlg], ID_x1, x1, 2
    invoke GetDlgItemText, [hwnddlg], ID_x2, x2, 2
    invoke GetDlgItemText, [hwnddlg], ID_x3, x3, 2
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

; --------------------------------------------------------------------------
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

; --------------------------------------------------------------------------
section '.rsrc' resource data readable

  directory RT_DIALOG, dialogs

  resource dialogs, 37, LANG_RUSSIAN, demonstration    

  dialog demonstration, 'Lab 7 - Variant 4', 70, 70, 120, 85, WS_CAPTION         
    dialogitem 'STATIC', 'x1:', 1, 10, 10, 20, 13, WS_VISIBLE      
    dialogitem 'EDIT', '', ID_x1, 30, 8, 20, 13, WS_VISIBLE+WS_BORDER+WS_TABSTOP  
    
    dialogitem 'STATIC', 'x2:', 1, 10, 25, 20, 13, WS_VISIBLE      
    dialogitem 'EDIT', '', ID_x2, 30, 23, 20, 13, WS_VISIBLE+WS_BORDER+WS_TABSTOP  
    
    dialogitem 'STATIC', 'x3:', 1, 10, 40, 20, 13, WS_VISIBLE      
    dialogitem 'EDIT', '', ID_x3, 30, 38, 20, 13, WS_VISIBLE+WS_BORDER+WS_TABSTOP  
    
    dialogitem 'BUTTON', 'OK', IDOK, 15, 60, 40, 15, WS_VISIBLE+WS_TABSTOP+BS_DEFPUSHBUTTON  
    dialogitem 'BUTTON', 'Cancel', IDCANCEL, 60, 60, 40, 15, WS_VISIBLE+WS_TABSTOP     
  enddialog