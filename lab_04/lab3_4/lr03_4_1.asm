PUBLIC X ; Метка будет видна из других файлов
EXTRN exit: far ;Определена в другом файле

SSTK SEGMENT para STACK 'STACK'
	db 100 dup(0)
SSTK ENDS

SD1 SEGMENT para public 'DATA'
	X db 'X'
SD1 ENDS

SC1 SEGMENT para public 'CODE'
	assume CS:SC1, DS:SD1 ; сообщаем ассемблеру какой сегментный регистр используем для доступа к сегменту
main:	
	jmp exit ; переход на метку exit
SC1 ENDS
END main