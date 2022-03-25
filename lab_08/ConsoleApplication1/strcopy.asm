.MODEL FLAT, C
.CODE
.STACK
.686

strcopy PROC C TO:DWORD, FROM:DWORD, LEN:DWORD
    mov esi, from ; esi = str2
    mov edi, to ; edi = str1
    mov ecx, len ; ecx = len
    ; выполняем ecx раз
    REP movsb ; пересылаем из esi(str2) в edi(str1)
    mov al, 0
    mov [edi], al
    ret
strcopy ENDP
END