format PE GUI 4.0
entry start

include 'C:\Users\jar0s\msis\INCLUDE\WIN32A.INC'

ID_x = 101

section '.data' data readable writeable

  x       rb 120    
  rez     rb 120    
  caption db 'Rezultat',0
  error   db 'Oshibka! Vvedite frazu!',0

section '.code' code readable executable

  start:
    xor eax, eax
    invoke DialogBoxParam, eax, 37, HWND_DESKTOP, DialogProc, 0
    or eax, eax
    jz exit

    ; Проверка на пустую строку
    lea esi, [x]
    mov al, [esi]
    cmp al, 0
    jnz process
    invoke MessageBox, HWND_DESKTOP, error, caption, MB_OK
    jmp exit

  process:
    lea esi, [x]      ; Указатель на исходную строку
    lea edi, [rez]    ; Указатель на строку-результат

  .loop_main:
    mov al, [esi]     ; Читаем символ
    cmp al, 0         ; Если конец строки (нуль-терминатор)
    je .done          ; Завершаем обработку

    mov [edi], al     ; Записываем символ в результат
    inc edi           ; Сдвигаем указатель результата
    cmp al, ' '       ; Был ли это пробел?
    jne .next_char    ; Если нет, идем к следующему символу

  .skip_spaces:
    ; Если мы записали пробел, пропускаем все следующие за ним пробелы
    inc esi           
    mov al, [esi]
    cmp al, ' '       
    je .skip_spaces   ; Если снова пробел - крутимся в цикле пропуска
    jmp .loop_main    ; Как только пошла буква - возвращаемся в главный цикл

  .next_char:
    inc esi           ; Сдвигаем указатель исходной строки
    jmp .loop_main    ; Возвращаемся в начало

  .done:
    mov byte [edi], 0 ; Ставим нуль-терминатор в конце строки-результата

    ; Вывод преобразованной фразы
    invoke MessageBox, HWND_DESKTOP, rez, caption, MB_OK

  exit:
    invoke ExitProcess, 0

; --------------------------------------------------------------------------
proc DialogProc, hwnddlg, msg, wparam, lparam
    push ebx esi edi
    cmp [msg], WM_INITDIALOG
    je .processed
    cmp [msg], WM_COMMAND
    je .wmcommand
    cmp [msg], WM_CLOSE
    je .wmclose
    xor eax, eax
    jmp .finish
  .wmcommand:
    cmp [wparam], BN_CLICKED shl 16 + IDCANCEL
    je .wmclose
    cmp [wparam], BN_CLICKED shl 16 + IDOK
    jne .processed
    
    invoke GetDlgItemText, [hwnddlg], ID_x, x, 120
  .topmost_ok:
    invoke EndDialog, [hwnddlg], 1
    jmp .processed
  .wmclose:
    invoke EndDialog, [hwnddlg], 0
  .processed:
    mov eax, 1
  .finish:
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

  dialog demonstration, 'Lab 8 - Variant 1', 100, 100, 310, 60, WS_CAPTION 
    dialogitem 'STATIC', 'Fraza:', 1, 10, 10, 30, 8, WS_VISIBLE    
    dialogitem 'EDIT', '', ID_x, 45, 8, 247, 13, WS_VISIBLE+WS_BORDER+WS_TABSTOP    
    dialogitem 'BUTTON', 'OK', IDOK, 100, 35, 45, 15, WS_VISIBLE+WS_TABSTOP+BS_DEFPUSHBUTTON  
    dialogitem 'BUTTON', 'Cancel', IDCANCEL, 160, 35, 45, 15, WS_VISIBLE+WS_TABSTOP       
  enddialog