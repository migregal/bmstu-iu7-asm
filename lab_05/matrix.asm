.186

EXTRN M: byte
EXTRN MAX_M: byte
EXTRN N: byte
EXTRN MAX_N: byte
EXTRN R: byte
EXTRN MATRIX: byte


SC3 SEGMENT PARA PUBLIC 'CODE'
    assume CS:SC3
get_max_row proc far
    pusha

    mov AX, SEG N
    mov ES, AX

    xor AX, AX
    xor BX, BX
    xor CH, CH
max:
    cmp CH, ES:N
    je max_end

    mov DX, AX
    mov AX, BX
    mul ES:MAX_M
    mov SI, AX

    mov AX, DX
    xor DX, DX

    xor CL, CL
row_sum:
    cmp CL, ES:M
    je row_sum_end

    add DL, ES:Matrix[SI]

    inc CL
    inc SI
    jmp row_sum
row_sum_end:
    cmp AL, DL
    jge continue

    mov AL, DL
    mov AH, CH

continue:
    inc BX
    inc CH
    jmp max

max_end:
    inc AH
    mov ES:R, AH

    popa
    ret

get_max_row endp

delete_row proc far
    pusha

    mov AX, SEG R
    mov ES, AX

    xor AX, AX
    mov AL, ES:R

    cmp AL, ES:N
    je move_exit

    dec AL
    mul ES:MAX_M

    mov DI, AX

    xor CX, CX
    xor DX, DX
copy_row:
    mov SI, DI

    mov CL, ES:N
    sub CL, ES:R
copy_symbol:

    xor BX, BX
    mov BL, ES:MAX_M
    mov AL, ES:Matrix[SI][BX]
    mov ES:Matrix[SI], AL
    add SI, BX

    loop copy_symbol

    inc DI
    inc DL
    cmp DL, ES:M
    jne copy_row

move_exit:
    dec ES:N

    popa
    ret
delete_row endp

SC3 ENDS

PUBLIC get_max_row
PUBLIC delete_row

END
