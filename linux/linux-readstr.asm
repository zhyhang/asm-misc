;-----------------------------------------------
; NASM Linux64 linking example
; Compile(include debug info) >> nasm -F dwarf -g -f elf64 this.asm
; Use nasm 2.15+
; Dynamic Link >> ld this.o /data/clouds/OneDrive/code/assembly/baselibs-2020/cpu2.0/cpu2/cpu2.o
;                 --dynamic-linker=/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 -o this
; Static Link  >>  ld this.o /data/clouds/OneDrive/code/assembly/baselibs-2020/cpu2.0/cpu2/cpu2.o this
; Run          >> ./this (chmod if needed)
;                 Will loop running, ctrl+c or quit/exit to terminate


;-----------------------------------------------
; Observe "_start" entry point
;-----------------------------------------------

%define m_calc(=x) x ; can run in nasm 2.15+

; constants
%define INPUT_BUF_SIZE 1025
%define MAX_INPUT_LEN m_calc(INPUT_BUF_SIZE - 1)
%defstr MAX_INPUT_LEN_S MAX_INPUT_LEN
;%define m_max_input_len m_input_buf_size - 1 ; can run in nasm 2.14+
;%defstr m_max_input_len_s m_max_input_len
%define QUIT_CMD_LEN 4
%define QUIT_CMD1 'quit'
%define QUIT_CMD2 'exit'



        ;default rel
        global _start

        extern mem_alloc  ;Import these from cpu2.o
        extern prnstrz
        extern prnline
        extern readch
        extern readstr
        extern prnintu
        extern exitx
        extern increase_one


        section .data align=32
msg_buf_alloc_err:  db 'Allocate mem fatal error!', 0ah, 0
msg_input:          db 'Please enter your chars (max length=', MAX_INPUT_LEN_S,'):', 0ah, 0
msg_output_b:       db 'Your input is (len=', 0
msg_output_a:       db '):', 0ah, 0
msg_overflow:       db 0ah,'!!Over max input length, discard extra chars!!', 0ah, 0

        section .text
_start:
        mov     rbp,rsp ; for sasm debug            
        
        ;>>>>buffer allocation
        mov     rdi, INPUT_BUF_SIZE
        call    mem_alloc
        cmp     rax, -1
        je      .fatal_error_exitx
        mov     r12, rax ;save buffer address, according to ABI, callee is responsible of keeping r12-r15 original value

.begin_input:        
        mov     rbx, r12

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
        ;>>>>rbx++, using lib call (for test)
        mov     rdi,rbx
        call    increase_one
        mov     rbx,rax
        inc     r13
        cmp     r13, MAX_INPUT_LEN
        jnl     .prn_overflow ;reach to the max buffer length      
        jmp     .read_input_chr
        
.prn_overflow:
        call    __swallon_over_input
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
        
        call    __check_exit_cmd
        test    rax, 1
        jnz     .normal_exit
        
        call    prnline
        call    prnline
        jmp     .begin_input ;loop run
        
.fatal_error_exitx:
        mov     rdi, msg_buf_alloc_err
        call    prnstrz
        
.normal_exit:
        call    exitx

__swallon_over_input:
        call    readch
        cmp     al, 0ah ;meet the enter, finish
        jne     __swallon_over_input
        ret

__check_exit_cmd:
        cmp     r13, QUIT_CMD_LEN ; r13 holds input length
        jne     .ret_0
        cmp     dword [r12], QUIT_CMD1 ; r12 holds input addr
        je     .ret_1
        cmp     dword [r12], QUIT_CMD2
        jne     .ret_0
.ret_1:
        mov     rax, 1
        ret
.ret_0:
        xor     rax,rax
        ret
