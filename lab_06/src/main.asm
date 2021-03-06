EXTRN print_sign: near
EXTRN print_unsign: near
EXTRN print_bin: near
EXTRN print_hex: near
EXTRN read_numb: near
EXTRN newline: near

STK SEGMENT PARA STACK 'STACK'
    db 200 dup (?)
STK ENDS

SEGDATA SEGMENT PARA PUBLIC 'DATA'
    menu_prnt db "1. Enter number", 10, 13
              db "2. Print signed number", 10, 13
              db "3. Print unsigned number", 10, 13
              db "4. Convert to unsigned hexadecimal and print it", 10, 13
              db "5. Convert to signed binary and print it", 10, 13
              db "0. Exit", 10, 13
              db 10, 13
              db "Enter action: $"

    f_ptr     dw exit, read_numb, print_sign, print_unsign, print_hex, print_bin
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE, DS:SEGDATA, SS:STK
main:
    mov ax, SEGDATA
    mov ds, ax

    menu:
        mov ah, 9
        mov dx, 0
        int 21h

        mov ah, 1
        int 21h

        mov ah, 0
        sub al, '0'
        mov dl, 2
        mul dl
        mov bx, ax

        call newline
        call f_ptr[bx]
        call newline
    jmp menu

exit proc near
    mov ax, 4c00h
    int 21h
exit endp

SEGCODE ENDS
END MAIN
