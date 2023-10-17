; /*
;  * ----------------------------------------------------------------------------
;  * "THE BEER-WARE LICENSE" (Revision 42):
;  * @iv4n-t3a wrote this file.  As long as you retain this notice you
;  * can do whatever you want with this stuff. If we meet some day, and you think
;  * this stuff is worth it, you can buy me a beer in return.   Иван-Чай
;  * ----------------------------------------------------------------------------
;  */

%include "macro.asm"
%include "numout.asm"
%include "numin.asm"
%include "arrio.asm"
%include "random.asm"
%include "sort.asm"

section .text
	global _start

_start:
    call input_num
    mov edi, eax

    push edi
    MUL edi, 4
    ALLOC edi
    pop edi

    push esi
    push edi
    call input_arr
    pop edi
    pop esi

    push esi
    push edi
    call sort
    pop edi
    pop esi

    WRITE_STR newline_msg, newline_len
    call output_arr

    EXIT 0

section .data
	newline_msg db 0xa, 0xd
	newline_len equ $ - newline_msg
