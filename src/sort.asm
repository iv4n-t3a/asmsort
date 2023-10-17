section .text

sort:
    cmp edi, 1
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

    push eax
    push esi
    push edi
    call partition
    pop edi
    pop esi
    pop eax
    call find

    push edi
    mov edi, eax
    dec edi
    call sort
    pop edi

    push esi
    push edi
    dec eax
    sub edi, eax
    lea esi, [esi + 4*eax]
    call sort
    pop edi
    pop esi

_sort_ret:
    ret


find:
    mov ecx, edi
    dec ecx

_find_loop:
    cmp eax, [esi + 4*ecx]
    je _find_ret
    loop _find_loop
    mov ecx, edi

_find_ret:
    mov eax, ecx
    ret


partition:
    mov ebx, esi
    mov esi, 0

_partition_loop:

    dec esi
_partition_left_loop:
    inc esi

    cmp esi, edi
    jge _partition_ret

    cmp eax, [ebx + 4*esi]
    jg _partition_left_loop

    inc edi
_partition_right_loop:
    dec edi

    cmp esi, edi
    jge _partition_ret

    cmp eax, [ebx + 4*edi]
    jl _partition_right_loop

    ; swap over ecx and edx
    mov ecx, [ebx + 4*esi]
    mov edx, [ebx + 4*edi]
    mov [ebx + 4*esi], edx
    mov [ebx + 4*edi], ecx

    jmp _partition_loop

_partition_ret:
    ret
