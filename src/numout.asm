section .text

output_num:
	push eax
	call count_num_len
	mov  ecx, eax
	pop  eax

	push ecx
	call reverse_num
	pop  ecx

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
	je  _count_num_ret
	jmp _count_num_len_loop

_count_num_ret:
	mov eax, ebx
	ret

reverse_num:
	mov ebx, 0

_reverse_num_loop:
	DIV_EAX 10
	SWAP eax, ebx
	mov  ecx, edx
	MUL_EAX 10
	add  eax, ecx
	SWAP eax, ebx

	cmp eax, 0
	je  _reverse_num_ret
	jmp _reverse_num_loop

_reverse_num_ret:
	mov eax, ebx
	ret

section .bss
    output resb 1
