.186

EXTRN read_matrix: far
EXTRN get_max_row:far
EXTRN delete_row:far
EXTRN print_matrix:far

STACKSEG SEGMENT PARA STACK 'STACK'
    db 200h dup(0)
STACKSEG ENDS

DS1 SEGMENT PARA 'DATA'
    N       db  0
    MAX_N   db  9
    M       db  0
    MAX_M   db  9
    R       db  0
    MATRIX  db  9*9 dup(0)
DS1 ENDS

SC1 SEGMENT PARA PUBLIC 'CODE'
    assume DS:DS1
main:
    mov AX, DS1
    mov DS, AX

    call read_matrix

    call get_max_row

    call delete_row

    call print_matrix

    mov ax, 4c00h
    int 21h
SC1 ENDS

PUBLIC M
PUBLIC MAX_M
PUBLIC N
PUBLIC MAX_N
PUBLIC R
PUBLIC MATRIX

END main
