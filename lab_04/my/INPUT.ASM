public input

code segment public 'CODE'
assume cs:code
input:
    mov ah, 1 ;Считать строку символов из STDIN в буфер
    int 21h
    ret
code ends
end input