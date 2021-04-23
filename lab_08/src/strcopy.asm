global strcopy
section .text

strcopy:
    mov RCX, RDX
    cmp RSI, RDI
    jg SGETDIST
    jmp DGETDIST

    SGETDIST:
        mov RAX, RSI
        sub RAX, RDI

    DGETDIST:
        mov RAX, RDI
        sub RAX, RSI

    cmp RAX, RCX
    jg REPMOVSB

    cmp RSI, RDI
    jg REPMOVSB

    jmp REVERSE

    REPMOVSB:
        rep movsb
        jmp ENDCP

    REVERSE:
        add RDI, RCX
        add RSI, RCX
        dec RSI
        dec RDI
        CPY:
            movsb
            sub RSI, 2
            sub RDI, 2
            loop CPY
    ENDCP:
    ret
