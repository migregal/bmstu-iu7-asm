.186

EXTRN M: byte
EXTRN MAX_M: byte
EXTRN N: byte
EXTRN MAX_N: byte
EXTRN MATRIX: byte

DS2 SEGMENT PARA 'DATA'
    MSG1 db "Enter N:$"
    MSG2 db "Enter M:$"
    MSG3 db "Enter Matrix values:$"
    MSG4 db "Result:$"
DS2 ENDS

SC2 SEGMENT PARA PUBLIC 'CODE'
    assume CS:SC2, DS:DS2
newline proc
    push DX

    mov DL, 10
    mov AH, 02h
    int 21h
    mov DL, 13
    mov AH, 02h
    int 21h

    pop DX
    ret
newline endp

read_num proc
    push DX

    mov DL, ' '
    mov AH, 02h
    int 21h

    mov AH, 01h
    int 21h
    sub AL, '0'

    pop DX
    ret
read_num endp

read_data proc
    pusha

    mov AX, SEG M
    mov ES, AX

    xor BX, BX
read:
    cmp BL, ES:N
    je read_end

    xor CL, CL

    mov AX, BX
    mul ES:MAX_M
    mov SI, AX
read_row:
    cmp CL, ES:M
    je read_row_end

    call read_num

    mov ES:Matrix[SI], AL

    inc CL
    inc SI
    jmp read_row
read_row_end:
    inc BX
    call newline
    jmp read

read_end:
    popa
    ret
read_data endp

read_matrix proc far
    pusha

    mov AX, DS2
    mov DS, AX

    mov AX, SEG N
    mov ES, AX

    ;N
    mov DX, OFFSET MSG1
    mov AH, 09h
    int 21h

    call read_num
    mov ES:N, AL

    call newline

    ; M
    mov DX, OFFSET MSG2
    mov AH, 09h
    int 21h

    call read_num
    mov ES:M, AL

    call newline

    ; Matrix
    mov DX, OFFSET MSG3
    mov AH, 09h
    int 21h

    call newline

    call read_data

    popa
    ret
read_matrix endp

print_num proc
    push DX

    mov DL, ' '
    mov AH, 02h
    int 21h

    pop DX
    add DL, '0'

    mov AH, 02h
    int 21h

    ret
print_num endp

print_matrix proc far
    pusha

    mov AX, DS2
    mov DS, AX

    mov AX, SEG N
    mov ES, AX

    ; Matrix
    mov DX, OFFSET MSG4
    mov AH, 09h
    int 21h

    call newline

    xor CH, CH
print:
    cmp CH, ES:N
    je print_end

    xor AX, AX
    mov AL, CH
    mul ES:MAX_M
    mov BX, AX

    xor CL, CL
print_row:
    cmp CL, ES:M
    je print_row_end

    mov DL, ES:Matrix[BX]
    call print_num

    inc CL
    inc BX
    jmp print_row
print_row_end:
    inc CH
    call newline
    jmp print

print_end:

    popa
    ret
print_matrix endp
SC2 ENDS

PUBLIC read_matrix
PUBLIC print_matrix

END
