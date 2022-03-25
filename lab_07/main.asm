.model tiny

code SEGMENT
    assume cs:code, ds:code
    org 100h ; Располагается Префикс программного сегмента перед прочими сегментами программы
    
main:	
	jmp init  
	old        DD 0 ; хранит адрес старого обработчика прерываний от таймера
	timer      DB 0
	speed      DB 00h

my_tsr proc; резидентная часть программы
	pushf ; сохраняем содержимое регистров флагов FLAGS
	
	call cs:old; вызываем старый обработчик
	
	push ax; пушим в стек
	push bx
	push cx
	push dx
	push ds
	push es
	push si
	
	xor ax, ax
    mov al, ds:timer; в al закидываем таймер
    inc al ; timer + 1
    mov ds:timer, al ; возвращаем обратно

    cmp ds:timer, 18 
    jnz finish

    xor al, al
    mov ds:timer, al

	cmp ds:speed, 0 ; если скорость != 0
    jnz set_speed ; то уменьшаем ее
	
    mov al, 01Eh ; если скорость == 0
    mov ds:speed, al ;то делаем ее максимальной(01Eh)

    set_speed:
		mov al, ds:speed ; al = speed 
		dec al ; уменьшаем speed
		mov ds:speed, al ; возвращаем al в speed

		mov al, 0F3h ; команда автоповтора ввода символа (отвечает за параметры режима автоповтора нажатой клавиши)
		out 60h, al
		mov al, ds:speed ; cкорось автоповтора в мс(чем выше speed, тем ниже скорость повтора символов)
		out 60h, al ; отвечает за то с какой скоростью символы будут появляться

    finish: ; очищаем стек от регистров
		pop si
		pop es
		pop ds
		pop dx
		pop cx
		pop bx
		pop ax
		
		iret ; восстанавливаем флаги и IP
my_tsr endp

init:
	; установка вектора прерывания 08h
	;Для замены вектора прерывания на свой адрес используем функцию 35h
    mov ax, 3508h ; получение адреса обработчика
	int 21h
	mov word ptr old, bx ; в первые 2 байта переменной old bx	
	mov word ptr old + 2, es ; во вторые 2 байта переменной old es
	
	; Устанавливаем наш обработчик
	mov ax, 2508h ; AH = 25h, AL = 08
	mov dx, offset my_tsr ; DS:DX - адрес обработчика
	int 21h ; установить обработчик
	
	mov ax, 3100h; завершаем программу с сохранением резидентной части
	mov dx, (my_tsr - init + 10Fh) / 16 ; определение размера резидентной части программы в параграфах
	int 21h;	 
code ends
end main
