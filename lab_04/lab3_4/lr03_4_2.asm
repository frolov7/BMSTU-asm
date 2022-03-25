EXTRN X: byte ; выделели байт под x
PUBLIC exit

SD2 SEGMENT para 'DATA'
	Y db 'Y' ; выделели память под Y
SD2 ENDS

SC2 SEGMENT para public 'CODE'
	assume CS:SC2, DS:SD2; сообщаем ассемблеру какой сегментный регистр используем для доступа к сегменту
exit:
	mov ax, seg X ; Получение сегментного адресса и перенос его в ax
	mov es, ax ; установка es=seg X 
	mov bh, es:X ;

	mov ax, SD2 ;загрузка в AX адреса сегмента данных
	mov ds, ax ;установка DS

	xchg ah, Y ; Обмен значений правого и левого операнда
	xchg ah, ES:X ; Обмен значений правого и левого операнда
	xchg ah, Y	; Обмен значений правого и левого операнда

	mov ah, 2 ; функция DOS вывода на экран
	mov dl, Y ; поместить символ в DL
	int 21h	;Обращение к функции DOS
	
	mov ax, 4c00h ; Dos функция выхода из программы 
	int 21h ; завершить программу 
SC2 ENDS
END