;Compile >> nams -gdwarf -f elf64 this.asm
;GDB can step into this file from caller in term of -gdwarf

    global increase_one

    section .data align=32

    section .text

align 8
increase_one:
    inc     rdi
    mov     rax,rdi
    ret
