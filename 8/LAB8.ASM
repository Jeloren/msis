; Пример выполнения лабораторной работы №8 по ассемблеру
; Вариант № 15
; Дана фраза. Удалить в ней лишние пробелы. Зашифровать ее, записав каждое ее второе слово в обратном порядке и подсчитать их количество.

format PE GUI 4.0   
entry start

include 'C:\Users\jar0s\msis\INCLUDE\WIN32A.INC'

ID_x          = 101    

section '.data' data readable writeable       

  x  rb 120     ; зарезервируем 120 байт для ввода исходной строки
  caption db 'Решение',0     ;заголовок для окна с ответом
  error   db 'Ошибка ввода!!!',0dh,0ah,'Необходимо ввести фразу!',0
  message rb 61               ;зарезервируем 60 байт для зашифрованной строки
  slovo   rb 60               ;зарезервируем 60 байт для слова
  adr     dd  0               ;переменная для хранения адреса зашифрованной строки
  posl_sl dw  0               ;переменная для хранения параметра последнее слово
  y       db  0dh,0ah,'Результирующая строка:',0dh,0ah
  z       db 0dh,0ah,'Кол-во четных слов='
  otvet   db  'Исходная строка:',0dh,0ah
  rez       rb  300

section '.code' code readable executable    

  start:
    xor    eax,eax       ;ЕАХ=0
    invoke DialogBoxParam,eax,37,HWND_DESKTOP,DialogProc,0  
    or     eax,eax       
    jz     exit          
    lea    edi, [x]      
    xor    eax,eax       
    mov    al,[edi]      
    or     eax,eax       
    jnz    norm          
    invoke MessageBox,HWND_DESKTOP,error,caption,MB_OK 
    jmp    exit
 norm:   
     xor    ecx,ecx     ;CX=0 (Если CX=0,то первое слово.CX=1,то второе слово.)
     xor    ebx,ebx     ;BX=0 (длина слова)
     xor    edx,edx     ;DX=0 кол-во четных (2-х) слов
     mov    [posl_sl],0
     push   edi
     lea    edi, [message] ;загрузим в регистр edi адрес зашифрованной строки
     mov    [adr],edi     ;сохраним адрес в переменной adr
     pop    edi
     lea    esi, [slovo]  ;загрузим в регистр esi адрес слова
     
while_1:                  ; ИСПРАВЛЕНО: метка while заменена на while_1
     cmp    al,0          ;AL=0 (достигнут конец введенной строки)
     jz     posl
     cmp    al,' '        ;
     jz     end_w
     mov    [esi],al
     inc    ebx
     inc    esi
     jmp    next
end_w:   
     or     ebx,ebx       ;если длинна слова=0, то переход к следующему символу
     jz     next
     xor    al,al         ;al=0
     mov    [esi],al      ;завершим полученное слово кодом 0
vib_sl:  
     or     cx,cx         ;слово первое или второе?
     jz     perv          ;если cx=0, то первое
;2-е слово
     inc    edx
     push   edi
     mov    cx,bx        ;cx=длине слова
     mov    edi,[adr]    ;edi=адресу строки для вывода
     lea    esi,[slovo]  ;загрузим в регистор esi адрес слова
     add    esi,ebx
loop1:   
     dec    esi
     mov    al,[esi]
     mov    [edi],al
     inc    edi
     loop   loop1
     mov    al,' '       ;Добавим пробел после слова
     mov    [edi],al
     inc    edi
     mov   [adr], edi
     pop    edi
     xor    cx,cx         ;следующее слово будет первым(нечетным)
     jmp    m1
;последнее слово
posl:     
      mov    [posl_sl],1
      jmp    vib_sl

;1-е слово
perv:
;Перепишем slovo без изменений в строку для вывода
     push   edi
     mov    cx,bx        ;cx=длине слова
     mov    edi,[adr]    ;edi=адресу строки для вывода
     lea    esi, [slovo] ;загрузим в регистор esi адрес слова
     CLD             ;Сброс флага DF
     REP MOVSB         ;Переслать cx байт с адреса ds:esi на адрес ds:edi
     mov    al,' '       ;Добавим пробел после слова
     mov    [edi],al
     inc    edi
     mov   [adr], edi
     pop    edi
     mov    cx,1        ;cx=1 (следующее слово будет вторым)
m1:     
     cmp    [posl_sl],1    ;слово было не последним?
     jz     vivod

;пропустим лишние пробелы
while2:  
     Inc    edi          ;edi=edi+1
     mov    al,[edi]      ;загрузим в al следующий символ введенной строки
     cmp    al,0          ;AL=0 (достигнут конец введенной строки)
     jz     posl
     cmp    al,' '        ;
     jz     while2
e_w2:     
     xor    ebx,ebx       ;очистим счетчик символов слова
     lea    esi, [slovo]  ;загрузим в регистор esi адрес слова
     jmp    while_1       ; ИСПРАВЛЕНО: переход на while_1
next:     
     Inc    edi          ;edi=edi+1
     mov    al,[edi]      ;загрузим в al следующий символ введенной строки
     jmp    while_1       ; ИСПРАВЛЕНО: переход на while_1
vivod:
;формирование ответа
    lea    esi,[x]
    lea    edi,[rez]
l_2:    
    mov    al,[esi]     ;загрузим в al следующий символ введенной строки
    cmp    al,0
    jz     l_3
    mov    [edi],al
    inc    edi
    inc    esi
    jmp    l_2
l_3:    
    lea    esi,[y]
    mov    cx,26
    CLD            ;Сброс флага DF
    REP MOVSB        ;Переслать cx байт с адреса ds:esi на адрес ds:edi
    lea    esi,[message]
l_4:    
    mov    al,[esi]     ;загрузим в al следующий символ введенной строки
    cmp    al,0
    jz     l_5
    mov    [edi],al
    inc    edi
    inc    esi
    jmp    l_4
l_5:    
    lea    esi,[z]
    mov    cx,21
    CLD            ;Сброс флага DF
    REP MOVSB        ;Переслать cx байт с адреса ds:esi на адрес ds:edi
    mov    eax,edx
    mov    esi, edi
    call   IntToStr
    invoke MessageBox,HWND_DESKTOP,otvet,caption,MB_OK
  exit:
    invoke ExitProcess,0

proc IntToStr; eax - число, esi - адрес строки для вывода
    pushad
    mov ebx,10
    xor ecx,ecx
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
    ret   ; ИСПРАВЛЕНО: было return
endp

proc DialogProc,hwnddlg,msg,wparam,lparam
    push   ebx esi edi
    cmp    [msg],WM_INITDIALOG
    je     processed
    cmp    [msg],WM_COMMAND
    je     wmcommand
    cmp    [msg],WM_CLOSE
    je     wmclose
    xor    eax,eax
    jmp    finish
 wmcommand:
    cmp    [wparam],BN_CLICKED shl 16 + IDCANCEL
    je     wmclose
    cmp    [wparam],BN_CLICKED shl 16 + IDOK
    jne    processed
    invoke GetDlgItemText,[hwnddlg],ID_x,x,120        ;вводим 60 символов
topmost_ok:
    invoke EndDialog,[hwnddlg],1
    jmp    processed
  wmclose:
    invoke EndDialog,[hwnddlg],0
  processed:
    mov    eax,1
  finish:
    pop    edi esi ebx
    ret    ; ИСПРАВЛЕНО: было return
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

  dialog demonstration,'Laboratornaya rabota 8 (Variant 15)',100,100,310,60,WS_CAPTION 
    dialogitem 'STATIC','Fraza:',1,10,10,100,8,WS_VISIBLE   
    dialogitem 'EDIT','',ID_x,29,8,247,13,WS_VISIBLE+WS_BORDER+WS_TABSTOP    
    dialogitem 'BUTTON','OK',IDOK,100,35,45,15,WS_VISIBLE+WS_TABSTOP+BS_DEFPUSHBUTTON  
    dialogitem 'BUTTON','C&ancel',IDCANCEL,160,35,45,15,WS_VISIBLE+WS_TABSTOP          
  enddialog