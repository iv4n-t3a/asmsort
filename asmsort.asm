; /*
;  * ----------------------------------------------------------------------------
;  * "THE BEER-WARE LICENSE" (Revision 42):
;  * @iv4n-t3a wrote this file.  As long as you retain this notice you
;  * can do whatever you want with this stuff. If we meet some day, and you think
;  * this stuff is worth it, you can buy me a beer in return.   Иван-Чай
;  * ----------------------------------------------------------------------------
;  */
%assign SYS_EXIT  1
%assign SYS_READ  3
%assign SYS_WRITE 4
%assign SYS_BRK   45

%assign STDIN  0
%assign STDOUT 1
%assign STDERR 2


%macro EXIT 1
    mov eax, SYS_EXIT
    mov ebx, %1
    int 0x80
%endmacro

%macro WRITE_STR 2
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro

%macro READ_STR 2
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro

%macro SWAP 2
    mov esi, %1
    mov %1, %2
    mov %2, esi
%endmacro

%macro DIV_EAX 1
    mov edx, 0
    mov esi, %1
    div esi
%endmacro


section .text
	global _start

_start:
    call input_num
    push eax
    call input_num
    pop ebx
    add eax, ebx
    call output_num
    EXIT 0


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
    DIV_EAX 10
    mov long [output], edx
    add long [output], '0'

    push eax
    push ecx

    WRITE_STR output, 1

    pop ecx
    pop eax

    loop _output_num_loop
    WRITE_STR newline_msg, newline_len
    ret


count_num_len:
    mov ebx, 0

_count_num_len_loop:
    DIV_EAX 10
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
    DIV_EAX 10
    SWAP eax, ebx
    mov ecx, edx
    mov edx, 10
    mul edx
    add eax, ecx
    SWAP eax, ebx

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
