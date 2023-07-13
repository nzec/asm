section .data
    hello: db "Hello"
    helloLen: equ $ - hello
    world: db " World! ", 10
    worldLen: equ $ - hello

section .text
    global _start

_start:
    call print
    mov byte [print_world - 1], 90h
    mov byte [print_world - 2], 90h
    call print
    call exit

print:
    mov rax, 1
    mov rdi, 1
    jmp print_hello

print_world:
    mov rsi, world
    mov rdx, worldLen
    jmp print_end

print_hello:
    mov rsi, hello
    mov rdx, helloLen

print_end:
    syscall
    ret

exit:
    mov rax, 60
    mov rdi, 0
    syscall
    ret
