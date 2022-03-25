extern input: near
stk Segment public 'STACK'
    DB 100 dup(0)
stk ends

code segment public 'CODE'
    assume cs:code, ss:stk
main:
    call input ; переход на метку input 
    
    mov dl, al ; поместить символ в DL

    mov ah, 2h ; функция DOS вывода на экран
    int 21h ; вывести на экран символ

    mov ah, 4Ch ; функция DOS завершения программы
    int 21h ; завершить программу
code ends
END main