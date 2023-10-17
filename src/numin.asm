section .text

input_num:
    mov eax, 0

_input_num_loop:
    push eax
    READ_STR {input}, 1

    cmp word [input], '9'
    jg _input_num_ret

    cmp word [input], '0'
    jl _input_num_ret

    pop eax
    MUL_EAX 10
    add eax, [input]
    sub eax, '0'
    jmp _input_num_loop

_input_num_ret:
    pop eax
    ret

section .bss
    input resb 1
