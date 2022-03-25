SD1 SEGMENT para public 'DATA'
	S1 db 'Y'
	db 65535 - 2 dup (0); кол-во нулей под память сегмента 
SD1 ENDS

SD2 SEGMENT para public 'DATA'
	S2 db 'E'
	db 65535 - 2 dup (0); кол-во нулей под память сегмента 
SD2 ENDS

SD3 SEGMENT para public 'DATA'
	S3 db 'S'
	db 65535 - 2 dup (0) ; кол-во нулей под память сегмента 
SD3 ENDS

CSEG SEGMENT para public 'CODE'
	assume CS:CSEG, DS:SD1
output:
	mov ah, 2 ; функция DOS вывода на экран
	int 21h   ;Обращение к функции DOS
	mov dl, 13 ; Перевод курсора в начало строки
	int 21h   ;Обращение к функции DOS
	mov dl, 10 ; Переход на следующую строку
	int 21h   ;Обращение к функции DOS
	ret ;Вернуться в программу.
main:
	mov ax, SD1 ;загрузка в AX адреса сегмента данных 
	mov ds, ax ;установка DS
	mov dl, S1 ; поместить символ букву Y в DL
	call output ; переход на метку output
assume DS:SD2
	mov ax, SD2 ;загрузка в AX адреса сегмента данных 
	mov ds, ax;установка DS
	mov dl, S2; поместить символ юукву E в DL
	call output ; переход на метку output
assume DS:SD3
	mov ax, SD3;загрузка в AX адреса сегмента данных 
	mov ds, ax;установка DS
	mov dl, S3; поместить символ юукву S в DL
	call output
	
	mov ax, 4c00h; Dos функция выхода из программы 
	int 21h ; завершить программу 
CSEG ENDS
END main