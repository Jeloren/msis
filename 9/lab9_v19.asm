format PE GUI 4.0
entry start

include 'C:\Users\jar0s\msis\INCLUDE\WIN32A.INC'

ID_STR = 101

section '.data' data readable writeable
  input_str rb 120          ; Bufer dlya vvoda stroki
  caption   db 'Rezultat',0
  error     db 'Oshibka! Vvedite stroku.',0
  
  ; Шаблон для вывода (знак '_' находится на 12-й позиции, считая с нуля)
  message   db 'Max simvol: _',0 

section '.code' code readable executable

  start:
    xor eax, eax
    invoke DialogBoxParam, eax, 37, HWND_DESKTOP, DialogProc, 0
    or eax, eax
    jz exit

    ; Проверка на пустую строку
    lea esi, [input_str]
    mov al, [esi]
    cmp al, 0
    jnz find_max
    invoke MessageBox, HWND_DESKTOP, error, caption, MB_OK
    jmp exit

  find_max:
    lea esi, [input_str]    ; Указатель на начало строки
    xor dl, dl              ; В DL будем хранить максимальный символ (начинаем с 0)

  .loop:
    mov al, [esi]           ; Читаем текущий символ в AL
    cmp al, 0               ; Если достигли конца строки (нуль-терминатор)
    je .done                ; Завершаем поиск

    cmp al, dl              ; Сравниваем текущий символ с максимальным
    jbe .skip               ; Если текущий меньше или равен максимальному (Jump if Below or Equal), пропускаем
    mov dl, al              ; Иначе обновляем максимальный символ в DL

  .skip:
    inc esi                 ; Переходим к следующему символу
    jmp .loop               ; Повторяем цикл

  .done:
    ; Готовим вывод
    lea edi, [message + 12] ; Адрес места в строке message, где стоит знак '_'
    mov [edi], dl           ; Записываем туда найденный символ
    
    ; Выводим ответ
    invoke MessageBox, HWND_DESKTOP, message, caption, MB_OK

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
    
    invoke GetDlgItemText, [hwnddlg], ID_STR, input_str, 120
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

  dialog demonstration, 'Variant 7 - Zadanie 4', 100, 100, 310, 60, WS_CAPTION 
    dialogitem 'STATIC', 'Stroka:', 1, 10, 10, 40, 8, WS_VISIBLE    
    dialogitem 'EDIT', '', ID_STR, 50, 8, 240, 13, WS_VISIBLE+WS_BORDER+WS_TABSTOP    
    dialogitem 'BUTTON', 'Naiti', IDOK, 100, 35, 45, 15, WS_VISIBLE+WS_TABSTOP+BS_DEFPUSHBUTTON  
    dialogitem 'BUTTON', 'Vyhod', IDCANCEL, 160, 35, 45, 15, WS_VISIBLE+WS_TABSTOP       
  enddialog