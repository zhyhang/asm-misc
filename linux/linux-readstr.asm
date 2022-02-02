;-----------------------------------------------
; NASM Linux64 linking example
; Compile(include debug info) >> nasm -F dwarf -g -f elf64 this.asm
; Use nasm 2.15+
; Dynamic Link >> ld this.o /data/clouds/OneDrive/code/assembly/baselibs-2020/cpu2.0/cpu2/cpu2.o
;                 --dynamic-linker=/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 -o this
; Static Link  >>  ld this.o /data/clouds/OneDrive/code/assembly/baselibs-2020/cpu2.0/cpu2/cpu2.o this
; Run          >> ./this (chmod if needed)
;-----------------------------------------------
; Observe "_start" entry point
;-----------------------------------------------

%define m_input_buf_size 65
%define m_calc(=x) x ; can run in nasm 2.15+
%define m_max_input_len m_calc(m_input_buf_size - 1)
%defstr m_max_input_len_s m_max_input_len
;%define m_max_input_len m_input_buf_size - 1 ; can run in nasm 2.14+
;%defstr m_max_input_len_s m_max_input_len
%strcat m_msg_over_input_buf '(!!Reach max input length(',m_max_input_len_s,')!!'

        ;default rel
        global _start

        extern mem_alloc  ;Import these from cpu2.o
        extern prnstrz
        extern prnline
        extern readch
        extern readchr
        extern readstr
        extern prnintu
        extern prnreg
        extern exitx

        section .data align=32
msg_buf_alloc_err:  db 'Allocate mem fatal error!', 0ah, 0
msg_input:          db 'Please enter your chars:', 0ah, 0 ;in sasm input window will not work, save exe and test in shell
msg_output_b:       db 'Your input is (len=', 0
msg_output_a:       db '):', 0ah, 0
msg_overflow:       db m_msg_over_input_buf, 0ah, 0

        section .text
_start:              
        ; todo loop run, terminate when receive ctrl+c
        ; todo clear over length input
        ;>>>>buffer allocation
        mov     rdi, m_input_buf_size
        call    mem_alloc
        cmp     rax, -1
        je      .fatal_error_exitx
        mov     r12, rax ;save buffer address, according to ABI, callee is responsible of keeping r12-r15 original value
        mov     rbx, rax
        
        ;>>>>print message
        mov     rdi, msg_input
        call    prnstrz
        
        ;>>>>loop read ch 
        xor     r13, r13
.read_input_chr:
        call    readch
        mov     [rbx], al
        cmp     al, 0ah ;meet the enter, finish
        je      .prn_input
        inc     rbx
        inc     r13
        cmp     r13, m_max_input_len
        jnl     .prn_overflow ;reach to the max buffer length      
        jmp     .read_input_chr
        
.prn_overflow:
        mov     rdi, msg_overflow
        call    prnstrz
        
.prn_input:    
        call    prnline
        
        mov     byte [rbx], 0 ;change last char to 0
        mov     rdi, msg_output_b
        call    prnstrz
        mov     rdi, r13
        call    prnintu
        mov     rdi, msg_output_a
        call    prnstrz
        
        mov     rdi, r12
        call    prnstrz
        jmp     .normal_exit
        
.fatal_error_exitx:
        mov     rdi, msg_buf_alloc_err
        call    prnstrz
        
.normal_exit:
        call    exitx
