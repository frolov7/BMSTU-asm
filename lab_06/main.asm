EXTRN print_bin: near
EXTRN print_hex: near
EXTRN read_num: near
EXTRN new_line: near


stk SEGMENT PARA STACK 'stack'
    db 200 dup (?)
stk ENDS

segdata SEGMENT PARA PUBLIC 'DATA'
    menu_prnt db "1. Enter number"
              db 10
              db 13
              db "2. Convert to unsigned binary and print it"
              db 10
              db 13
              db "3. Convert to signed hexadecimal and print it"
              db 10
              db 13                            
              db "0. Exit" 
              db 10
              db 13
              db "Enter action: $"

    f_ptr dw 4 DUP (0)
segdata ENDS

segcode SEGMENT PARA PUBLIC 'code'
    assume cs:segcode, ds:segdata, ss:stk
main:
    call new_line ; вывод новой строки
    mov ax, segdata
    mov ds, ax ; установить DS в segdata 

    mov f_ptr[0], read_num ; пункты меню
    mov f_ptr[2], print_bin
    mov f_ptr[4], print_hex

    menu:
        mov ah, 9 ; вывод меню
        xor dx, dx
        int 21h

        mov ah, 1 ; ввод пункта
        int 21h

        xor ah, ah ; считать строку символа в буфер
        cmp al, '0'
        je exit
        sub al, "1" ; цифра = код цифры - код символа '1'
        mov dl, 2 ; закидываем 2 в dl
        mul dl ; ax = 2 * "1"
        mov bx, ax ; - выбранный пункт из f_ptr

        call new_line ; вывод новой строки
        call f_ptr[bx] ; вызов выбранной функции
        call new_line ; вывод новой строки
    jmp menu

exit proc near ; пункт 0 - выход
    mov ax, 4c00h
    int 21h
exit ENDP

segcode ENDS
END main