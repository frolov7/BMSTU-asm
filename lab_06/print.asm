PUBLIC print_bin
PUBLIC new_line
PUBLIC print_hex

EXTRN real_num: near
EXTRN num: near
EXTRN bin_len: byte
EXTRN bin_str: byte
EXTRN hex_str: byte
EXTRN hex_len: byte

SEGDATA SEGMENT PARA PUBLIC 'DATA'
    sign_msg   db "Signed num:"
               db 10
               db 13
               db "$"

    bin_msg    db "Unsigned binary:"
               db 10
               db 13
               db "$"

    hex_msg    db "Signed hexadecimal:"
               db 10
               db 13
               db "$"
SEGDATA ENDS
SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE, DS:SEGDATA

print_bin proc near
    call new_line

    mov ah, 9
    mov dx, offset bin_msg
    int 21h

    mov dx, offset bin_str
    int 21h

    call new_line
    ret

print_bin endp


print_hex proc near
    call new_line
    
    mov ah, 9
    mov dx, offset hex_msg
    int 21h

    mov dx, offset hex_str
    ; add dx, 5
    ; mov al, hex_len
    ; sub dl, al
    int 21h

    call new_line
    ret

print_hex endp


new_line proc near
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h

    ret
new_line endp

SEGCODE ENDS
END