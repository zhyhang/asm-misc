%define m_msg 'Hello world!'

section .data
    msg db 'Hello, world!', 0ah, 0
    msg_len equ $-msg

section .text
    global _start
    
_start:
    mov rbp, rsp; for correct debugging
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msg_len
    syscall
    mov rax, 60
    mov rdi, 0
    syscall
    
    