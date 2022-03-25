EXTRN output_X: near ; метка перехода для JMP в том же сегменте (без изменения CS)

STK SEGMENT PARA STACK 'STACK'
	db 100 dup(0) ; Выделели 100 байт для стека
STK ENDS

DSEG SEGMENT PARA PUBLIC 'DATA'
	X db 'R' ; память под символ
DSEG ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG, DS:DSEG, SS:STK ; сообщаем ассемблеру какой сегментный регистр используем для доступа к сегменту
main:
	mov ax, DSEG;загрузка в AX адреса сегмента данных
	mov ds, ax;установка DS

	call output_X ; вызов output_x

	mov ax, 4c00h; DOS функция выхода из программы
	int 21h ;Выход из программы
CSEG ENDS

PUBLIC X

END main