%assign RANDOM_SEED       1289461682
%assign RANDOM_SUMMAND    3542491627
%assign RANDOM_MULTIPLIER 1570108727

section .text

update_next_random:
    mov eax, [next_random]
    MUL_EAX RANDOM_MULTIPLIER
    add eax, edx
    add eax, RANDOM_SUMMAND
    mov [next_random], eax
    ret

section .bss
    next_random resb RANDOM_SEED
