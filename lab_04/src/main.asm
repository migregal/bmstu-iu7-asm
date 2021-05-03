STACKSEG SEGMENT PARA STACK 'STACK'
    DB 100 DUP(0)
STACKSEG ENDS

DATASEG1 SEGMENT PARA 'DATA'
    A db ' '
	M db 0
DATASEG1 ENDS

DATASEG2 SEGMENT PARA 'DATA'
    B db ' '
DATASEG2 ENDS

CODESEG SEGMENT PARA public 'CODE'
	assume CS:CODESEG, DS:DATASEG1, ES:DATASEG2
newline:
	mov DL, 10
    mov AH, 02h
    int 21h
    mov DL, 13
    mov AH, 02h
    int 21h
	ret
output:
	mov ah, 2
	int 21h
	call newline
	ret
calc:
    mov AL, A
    add AL, M
    mov B, AL
    ret
main:
    mov AX, DATASEG1
    mov DS, AX
    
    mov AH, 01
    int 21H
    mov A, AL
    call newline

    mov AX, DATASEG2
    mov ES, AX
    
    mov AH, 01
    int 21H
    mov M, AL
    sub M, '0'
    call newline

    call calc

    mov DL, B
    call output

    mov AH, 4CH
    int 21H
CODESEG ENDS
END main
