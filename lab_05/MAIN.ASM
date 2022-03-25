EXTRN read_sizes: far
EXTRN fill_matrix: far
EXTRN print_matrix: far
EXTRN check_cols: far
EXTRN remove_cols: far

data_matrix SEGMENT PARA COMMON 'matrix'
data_matrix ends

main_code SEGMENT PARA PUBLIC 'code'
    assume DS:data_matrix, CS:main_code ; сообщаем ассемблеру какой сегментный регистр используем для доступа к сегменту

main:
    mov ax, data_matrix ;загрузка в AX адреса сегмента данных
    mov DS, ax ;установка DS

    call read_sizes ; вызов read size

    cmp bx, 0 ; если все ок

    call fill_matrix ; заполнение матрицы
    call check_cols ; подсчет суммы
    call remove_cols ; удаление столбца
    call print_matrix ; вывод матрицы

    mov ah, 4ch ; выход 
    int 21h ; из программы

main_code ends
end main