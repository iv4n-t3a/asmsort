section .text

sort:
    cmp edi, 0
    jle _sort_ret

    push esi
    push edi
    call update_next_random
    mov eax, [next_random]
    DIV_EAX edi
    mov eax, edx
    pop edi
    pop esi
    mov eax, [esi + 4*eax]

    push esi
    push edi
    call partition
    pop edi
    pop esi

    push edi
    push eax
    mov edi, eax
    call sort
    pop eax
    pop edi

    push esi
    push edi
    inc eax
    sub edi, eax
    lea esi, [esi + 4*eax]
    call sort
    pop edi
    pop esi

_sort_ret:
    ret


partition:
    mov ebx, esi
    mov esi, 0

_partition_loop:

    dec esi
_partition_left_loop:
    inc esi
    cmp eax, [ebx + 4*esi]
    jg _partition_left_loop

    inc edi
_partition_right_loop:
    dec edi
    cmp eax, [ebx + 4*edi]
    jl _partition_right_loop

    cmp esi, edi
    jge _partition_ret

    SWAP {long [ebx + 4*esi]}, {long [ebx + 4*edi]}
    inc esi
    dec edi
    jmp _partition_loop

_partition_ret:
    mov eax, edi
    ret
