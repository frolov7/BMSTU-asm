PUBLIC output_X
EXTRN X: byte
; старший бит - признак мерцания символа
; затем 3 бита определяют цвет фона в формате RGB 
; Младшие 4 бита отвечают за цвет самого символа
DS2 SEGMENT AT 0b800h ; сегмент по указанному адресу 
	CA LABEL byte
	ORG 80 * 2 * 2 + 2 * 2; объявляет адрес, начиная с которого будет ассемблироваться программа
	SYMB LABEL word
DS2 ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG, ES:DS2 ; сообщаем ассемблеру какой сегментный регистр используем для доступа к сегменту
output_X proc near
	mov ax, DS2 ;загрузка в AX адреса сегмента данных
	mov es, ax ;установка ES
	mov ah, 10 ;Записать символ на позиции курсора
	mov al, X
	mov symb, ax
	ret ; возврат из процедуры
output_X endp
CSEG ENDS
END