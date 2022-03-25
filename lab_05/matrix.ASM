PUBLIC fill_matrix  
PUBLIC read_sizes
PUBLIC print_matrix

data_matrix SEGMENT PARA COMMON 'matrix'
    matrix_size DB 2h   DUP(?)
    matrix      DB 81   DUP(?)
    COL_FLAGS   DB 9h   DUP(0)
data_matrix ends

CodeSeg SEGMENT PARA PUBLIC 'code'
    assume CS:CodeSeg, DS:data_matrix ; сообщаем ассемблеру какой сегментный регистр используем для доступа к сегменту

print_n PROC near
    mov ah, 02h ; функция DOS вывода на экран
    mov dl, 13 ; возврат каретки \r
    int 21h ; перевод строки
    mov dl, 10 ;перевод курсора на новую строку
    int 21h
    ret ;Возврат из процедуры
print_n endp

print_space PROC near ; Функция вывода пробела при вводе
    mov ah, 02h ; функция DOS вывода на экран
    mov dl, ' ' ; поместить символ в DL
    int 21h ; вывод пробела
    ret ;Возврат из процедуры
print_space endp

read_digit PROC near
    mov ah, 01h ; считывание символа
    read_sym:
    int 21h
    ; Игнорируем все кроме цифр
    cmp al, '0' ; цифры ?
    jl  read_sym ; Если al < '0' то ОК
    sub al, '0' 
    cmp al, 9 
    jg  read_sym ; То все ок
    ret ;Возврат из процедуры
read_digit endp

read_sizes PROC far ; Считывание размера матрицы
    mov cx, 2 ; Счетчик = 2
    mov si, 0 ; индекс
    mov bx, 0 ; pегистр кода ошибки

    get_sizes: ; Ввод цифры размера
        call read_digit
        cmp al, 0 ; если все ок 
        jne good_size ; Если не 0
            mov bx, 1 ; ошибка = 1
            JMP to_ret ; Возвращаем ошибку
        good_size:
        mov matrix_size[si], al
        inc si ; увелечение si
        call print_space ; вывод пробела

    LOOP get_sizes ; Повтор ввода

    call print_n ; Переход на новую строку
    to_ret:
    call print_n ; Переход на новую строку
    ret
read_sizes endp
    
fill_matrix PROC far ; Ввод матрицы
    mov ah, 01h ; считывание символа
    mov bl, matrix_size[0] ; Передаем размер матрицы
    mov si, 0 ; индекс для массива, который содержит матрицу

    fill_rows:
        mov cl, matrix_size[1]
        fill_cols:
            call read_digit ; Считываем число

            mov matrix[si], al ; Заносим в матрицу
            inc si ; Увеличиваем индекс
            call print_space ; выводим пробел

            LOOP fill_cols ; Повторяем ввод матрицы

        dec bx ; bx - 1
        cmp bx, 0
        call print_n ; Переход на новую строку
    jne fill_rows ; Если не 0
    ret
fill_matrix endp

print_matrix PROC far
    cmp matrix_size[0], 0
    je end_show
    cmp matrix_size[1], 0
    je end_show

    mov bl, matrix_size[0]
    mov si, 0 ; индекс

    call print_n ; вывод пустой строки

    show_rows:
        mov cl, matrix_size[1]
        show_cols:
            mov dl, matrix[si]
            add dl, '0' ; работаем с цифрами
            int 21h
            call print_space
            inc si ; увеличиваем индекс
            LOOP show_cols
        dec bl ; - к размеру
        cmp bl, 0 ; если не дошли до конца
        call print_n
        jne show_rows ; выводим дальше
    end_show:
    ret
print_matrix endp

check_cols PROC far
    mov bx, 0 ; Текущий столбец
    mov dx, 0
    mov dl, matrix_size[1]

    run_cols:
        mov si, bx ; индекс элемента матрицы

        mov ax, 0 ; сумма столбца
        mov cl, matrix_size[0]

        run_rows:
            add al, matrix[si] ; подсчитать сумму
            add si, dx
            LOOP run_rows
        
        mov cl, 3 
        div cl ; Делим на 3
        cmp ah, 0 ; Если не нашли кратность
        jne not_mod_3
            mov COL_FLAGS[bx], 1h ; true
        
        not_mod_3:
        inc bl
        cmp bl, matrix_size[1] ; Пока не дошли до конца 
        jle run_cols ; Начинаем заново
    ret
check_cols endp

remove_cols PROC far
    mov dx, 0
    mov dl, matrix_size[1]
    run_columns:
        sub dl, 1
        mov di, dx
        mov al, COL_FLAGS[di]
        cmp al, 0
        je next_col ; переходим на след столбец
            call remove_col
        next_col:
        cmp dl, 0
        jne run_columns
    ret
remove_cols endp

remove_col PROC near
    mov si, 0
    mov di, 0
    mov bx, 0
    go_rows:
        mov cx, 0 
        go_cols:
            cmp cx, dx ; счетчик найденных разделителей
            jne no_col
                inc cl 
                inc di
                cmp cl, matrix_size[1]
                je rows_cycle
            no_col:
            mov al, matrix[di]
            mov matrix[si], al
            inc si 
            inc di
            inc cl 
            cmp cl, matrix_size[1]
            jl go_cols
        rows_cycle:
        inc bl
        cmp bl, matrix_size[0]
        JB go_rows
    sub matrix_size[1], 1
    ret
remove_col endp

CodeSeg ends
end