STK SEGMENT para STACK 'STACK'
	db 100 dup(0) ; Выделели 100 байт для стека
STK ENDS

SD1 SEGMENT para common 'DATA'
	W dw 3444h ; Переменная со значением 3444h
SD1 ENDS
END
