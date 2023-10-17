section .text

input_arr:
    mov ecx, edi

_input_arr_loop:
    push ecx
    push esi
    push edi
    call input_num
    pop edi
    pop esi
    pop ecx

    mov long [esi + 4*ecx], eax
    loop _input_arr_loop
    ret


output_arr:
    mov ecx, edi

_output_arr_loop:
    mov eax, long [esi + 4*ecx]

    push ecx
    push esi
    push edi
    call output_num
    pop edi
    pop esi
    pop ecx

    loop _output_arr_loop
    ret
