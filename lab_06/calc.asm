PUBLIC to_real_num
PUBLIC to_bin
.186

EXTRN real_num: near
EXTRN len: byte
EXTRN num: byte
EXTRN bin_len: byte
EXTRN bin_str: byte
EXTRN hex_len: byte
EXTRN hex_str: byte

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE


to_real_num proc near
    xor cx, cx

    mov cl, len
    dec cx
    mov si, cx

    mov bx, 1

    to_real_lbl:
        xor ax, ax
        mov al, byte ptr[num + si]
        sub ax, "0"
        mul bx
        add word ptr [real_num], ax

        mov ax, bx
        mov bx, 10
        mul bx
        mov bx, ax

        dec si

        loop to_real_lbl
    
    cmp byte ptr[num], '-'
    je invert

    ret
    invert:
        mov dx, word ptr[real_num]
        neg word ptr[real_num]
    ret

to_real_num endp

to_bin proc near
    xor si, si

    mov dx, word ptr[real_num]
    
    start_fun:
        mov cx, 16
        back:
            shl dx,1 ; двигаем влево
            jc write_one ; флаг выключается когда сдвинулась единциа
            mov bin_str[si], '0'; в другом случае тогда записываем 0
            con_loop:
                inc si
                loop back
        ret
        write_one:
            mov bin_str[si], '1'; записываем единицу
            jmp con_loop

to_bin ENDP


to_hex proc near
    cmp byte ptr[num], '-'
    je invert
    start:
        mov si, 1 ; в нулевой пишем знак, числа с 1 индекса
        mov ax, word ptr[real_num] ; указатель на число

    to_hex_lbl:
        mov cx, 4
        loop1:
            mov dl, ah
            shr dl, 4 ; записываем сюда разряды
            shl ax, 4 ; двигаем на один разряд
        
            mov hex_str[si], dl ; закидываем dl в массив с 16сс

            cmp dl, 9 ; если больше 9
            jg hex_char ; то переводим в букву
            add hex_str[si], "0" ; переводим в число
            back:
                inc si ; индекс hex str + 1
                loop loop1 ; повторяем цикл
    
    mov dh, byte ptr[num] ; закидываем знак
    mov hex_str[0], dh

    mov word ptr[real_num], 0 ; зануляем чтобы заново работало
    ret

    hex_char:
        add hex_str[si], 55 ; переводим в букву
        jmp back
    invert:
        mov dx, word ptr[real_num]
        neg word ptr[real_num]
        jmp start

to_hex endp

SEGCODE ENDS
END