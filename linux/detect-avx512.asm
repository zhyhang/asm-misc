;-----------------------------------------------
; Detect CPU supports AVX512 or not
; Compile(include debug info) >> nasm -F dwarf -g -f elf64 this.asm
; Static Link  >>  ld this.o /data/clouds/OneDrive/code/assembly/baselibs-2020/cpu2.0/cpu2/cpu2.o this
; Run          >> ./this (chmod if needed)
; Ref          >> https://stackoverflow.com/questions/6121792/how-to-check-if-a-cpu-supports-the-sse3-instruction-set
;              >> https://github.com/Mysticial/FeatureDetector
;              >> https://www.youtube.com/watch?v=543a1b-cPmU&t=218s

    global _start

    extern prnstrz
    extern prnline
    extern exitx

    section .data
msg_support:    db 'CPU supports AVX512 foundantion feature.', 0ah, 0

msg_unsuppt:    db 'CPU not supports AVX512 feature.', 0ah, 0

    section .text
_start:
        mov     eax, 07h
        xor     ecx, ecx
        cpuid
        shr     ebx, 16
        test    ebx, 1
        jz      .prn_unsupport

        mov     rdi, msg_support
        call    prnstrz
        jmp     .normal_exit

.prn_unsupport:
        mov     rdi, msg_unsuppt
        call    prnstrz

.normal_exit:
        call    exitx


