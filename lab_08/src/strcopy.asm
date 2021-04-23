global strcopy
section .text

strcopy:
    mov RCX, RDX
    cmp RSI, RDI
    jle STRAIGHT

    mov RAX, RDI
    sub RAX, RSI

STRAIGHT:
    cmp RAX, RCX
    jg REPMOVSB

    cmp RSI, RDI
    jle REVERSE

    REPMOVSB:
        rep movsb
        jmp exit

    REVERSE:
        add RDI, RCX
        add RSI, RCX
        dec RSI
        dec RDI

        std
        rep movsb
        cld

    exit:
    ret
