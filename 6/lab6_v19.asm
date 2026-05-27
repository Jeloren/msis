format PE GUI 4.0
entry start

include 'C:\Users\jar0s\msis\INCLUDE\WIN32A.INC'

ID_x = 101

section '.data' data readable writeable

  x       rb 10
  caption db 'Rezultat',0
  error   db 'Oshibka vvoda!!!',0
  message db 'F(x)=          ',0
  sys     dd 10

section '.code' code readable executable

  start:
    xor eax, eax
    invoke DialogBoxParam, eax, 37, HWND_DESKTOP, DialogProc, 0
    or eax, eax
    jz exit

    lea esi, [x]
    call StrToInt
    
    ; Проверка на корректность ввода
    or ecx, ecx
    jnz norm
    invoke MessageBox, HWND_DESKTOP, error, caption, MB_OK
    jmp exit

 norm:
    ; ==========================================
    ; ВЫЧИСЛЕНИЕ ФУНКЦИИ С УСЛОВИЕМ
    ; ==========================================
    cmp eax, 7          ; Сравниваем X (в EAX) с 7
    ja var_greater      ; Если X > 7 (Jump if Above), прыгаем на метку var_greater

    ; --- Ветка для X <= 7: F(x) = 3*x + 5 ---
    mov ebx, 3          ; Заносим множитель 3 в EBX
    mul ebx             ; EAX = EAX * 3 (т.е. 3*x)
    add eax, 5          ; EAX = 3*x + 5
    jmp vivod           ; Прыгаем к выводу, чтобы пропустить вторую ветку

 var_greater:
    ; --- Ветка для X > 7: F(x) = x^2 + 7 ---
    mul eax             ; EAX = EAX * EAX (т.е. x^2)
    add eax, 7          ; EAX = x^2 + 7

 vivod:
    ; Вывод результата
    lea esi, [message+6] 
    call IntToStr
    invoke MessageBox, HWND_DESKTOP, message, caption, MB_OK

  exit:
    invoke ExitProcess, 0

; --------------------------------------------------------------------------
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

; --------------------------------------------------------------------------
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
    jnc .errs
    add eax, edx
    jc .err2
    inc ecx
    inc esi
    jmp .l
  .err2:
    sub eax, edx
  .err:
    xor edx, edx
    jmp .exit
  .errs:
    xor ecx, ecx
    ret
  .exit:
    div [sys]
    ret
endp

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
    
    invoke GetDlgItemText, [hwnddlg], ID_x, x, 10   
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

  dialog demonstration, 'Lab 6 - Variant 5', 100, 100, 120, 60, WS_CAPTION  
    
    dialogitem 'STATIC', 'X=', 1, 10, 10, 15, 13, WS_VISIBLE      
    dialogitem 'EDIT', '', ID_x, 25, 8, 50, 13, WS_VISIBLE+WS_BORDER+WS_TABSTOP     
    
    dialogitem 'BUTTON', 'OK', IDOK, 10, 35, 45, 15, WS_VISIBLE+WS_TABSTOP+BS_DEFPUSHBUTTON  
    dialogitem 'BUTTON', 'Cancel', IDCANCEL, 60, 35, 45, 15, WS_VISIBLE+WS_TABSTOP        
  enddialog