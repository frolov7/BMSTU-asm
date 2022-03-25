DOSSEG
   .MODEL SMALL
   .STACK 100h
   .DATA
   .CODE
EhcoLoop:
   mov    ah,1              ; функция DOS ввода с
                            ; клавиатуры
   int    21h               ; получить следующую клавишу
   cmp    al,13             ; это клавиша ENTER?
   jz     EchoDone          ; да, выполняем эхоотображение
   mov    dl,al             ; поместить символ в DL
   mov    ah,2              ; функция DOS вывода на экран
   int    21h               ; вывести на экран символ
   jnz    EchoLoop          ; отобразить следующий символ
EchoDone:
   mov    ah,4ch            ; функция DOS завершения
                            ; программы
   int    21h               ; завершить программу
   END