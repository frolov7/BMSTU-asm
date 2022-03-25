SD1 SEGMENT para common 'DATA'
	C1 LABEL byte
	ORG 1h
	C2 LABEL byte
SD1 ENDS

CSEG SEGMENT para 'CODE'
	ASSUME CS:CSEG, DS:SD1 ; сообщаем ассемблеру какой сегментный регистр используем для доступа к сегменту
main:
	mov ax, SD1 ;загрузка в AX адреса сегмента данных
	mov ds, ax ;установка DS
	mov ah, 2  ; функция DOS вывода на экран
	mov dl, C1 ; поместить символ в DL
	int 21h
	mov dl, C2 ; поместить символ в DL
	int 21h
	mov ax, 4c00h ; DOS функция выхода из программы
	int 21h ; завершить программу
CSEG ENDS
END main