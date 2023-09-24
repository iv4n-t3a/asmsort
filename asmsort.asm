; /*
;  * ----------------------------------------------------------------------------
;  * "THE BEER-WARE LICENSE" (Revision 42):
;  * @iv4n-t3a wrote this file.  As long as you retain this notice you
;  * can do whatever you want with this stuff. If we meet some day, and you think
;  * this stuff is worth it, you can buy me a beer in return.   Иван-Чай
;  * ----------------------------------------------------------------------------
;  */

%define SYS_EXIT  1
%define SYS_READ  3
%define SYS_WRITE 4

%define STDIN  0
%define STDOUT 1
%define STDERR 2


section .text
	global _start


_start:
    call input_num
    push eax
    call input_num
    pop ebx
    add eax, ebx

    call output_num

    mov eax, SYS_EXIT
    mov ebx, 0
    int 0x80


input_num:
    mov eax, 0

_input_num_loop:
    push eax

    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, input
    mov edx, 1
    int 0x80

    cmp word [input], '9'
    jg _input_num_ret

    cmp word [input], '0'
    jl _input_num_ret

    pop eax
    mov edx, 10
    mul edx
    add eax, [input]
    sub eax, '0'

    jmp _input_num_loop

_input_num_ret:
    pop eax
    ret


output_num:
    push eax
    call count_num_len
    mov ecx, eax
    pop eax

    push ecx
    call reverse_num
    pop ecx

_output_num_loop:
    mov edx, 0
    mov esi, 10
    div esi
    mov long [output], edx
    add long [output], '0'

    push eax
    push ecx

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, output
    mov edx, 1
    int 0x80

    pop ecx
    pop eax

    loop _output_num_loop

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, newline_msg
    mov edx, newline_len
    int 0x80

    ret


count_num_len:
    mov ebx, 0

_count_num_len_loop:
    mov edx, 0
    mov esi, 10
    div esi
    inc ebx

    cmp eax, 0
    je _count_num_ret
    jmp _count_num_len_loop

_count_num_ret:
    mov eax, ebx
    ret


reverse_num:
    mov ebx, 0

_reverse_num_loop:
    mov edx, 0
    mov esi, 10
    div esi

    ; swap eax and ebx
    mov ecx, eax
    mov eax, ebx
    mov ebx, ecx

    mov ecx, edx
    mov edx, 10
    mul edx
    add eax, ecx

    ; swap eax and ebx
    mov ecx, eax
    mov eax, ebx
    mov ebx, ecx

    cmp eax, 0
    je _reverse_num_ret
    jmp _reverse_num_loop

_reverse_num_ret:
    mov eax, ebx
    ret


section .bss
	input resb 1
	output resb 1

section .data
	newline_msg db 0xa, 0xd
	newline_len equ $ - newline_msg
