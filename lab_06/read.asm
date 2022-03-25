PUBLIC read_num
PUBLIC num
PUBLIC len
PUBLIC real_num
PUBLIC bin_len
PUBLIC bin_str
PUBLIC hex_len
PUBLIC hex_str

EXTRN new_line: near
EXTRN to_real_num: near
EXTRN to_bin: near
EXTRN to_hex: near

SEGDATA SEGMENT PARA PUBLIC 'DATA'
    max_size   db 8
    len        db 0
    num        db 8 DUP ("$")

    bin_len    db 0
    bin_str    db 16 DUP ("0")
               db "$" 
    
    hex_len    db 0
    hex_str    db 6 DUP ("$")
               db "$"

    real_num  dw 0

    ent_msg  db "Enter number (with sign): $"
SEGDATA ENDS

segcode SEGMENT PARA PUBLIC 'code'
    assume cs:segcode, ds:segdata
read_num proc near
    call fill_nulls
    
    start:
    call new_line 

    mov ah, 9 ; выводим строку
    mov dx, offset ent_msg ; приглашение ввода
    int 21h

    mov ah, 0ah
    mov dx, offset max_size ; считываем строку
    int 21h

    call to_real_num
    call to_bin 
    call to_hex 
    call new_line 
    
    ret
read_num endp

fill_nulls proc near
    mov len, 0
    mov bin_len, 0
    mov hex_len, 0

    mov ax, seg num ; адрес начала сегмента 
    mov es, ax
    mov di, offset num ; адрес num смещает в di
    mov al, "$"
    mov cx, 8
    rep stosb ; увеличимвает di + 1 и конец строки после 8

    mov ax, seg bin_str
    mov es, ax
    mov di, offset bin_str
    mov al, "0"
    mov cx, 16
    rep stosb

    mov ax, seg hex_str
    mov es, ax
    mov di, offset hex_str
    mov al, "$"
    mov cx, 6
    rep stosb

    ret

fill_nulls endp
segcode ends
end