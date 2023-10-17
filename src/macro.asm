%assign SYS_EXIT  1
%assign SYS_READ  3
%assign SYS_WRITE 4
%assign SYS_BRK   45

%assign STDIN  0
%assign STDOUT 1
%assign STDERR 2

%assign RANDOM_SEED       1289461682
%assign RANDOM_SUMMAND    3542491627
%assign RANDOM_MULTIPLIER 1570108727


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

%macro ALLOC 1
    mov eax, SYS_BRK
    mov ebx, 0
    int 0x80

    mov esi, eax

    mov eax, SYS_BRK
    mov ebx, esi
    add ebx, %1
    int 0x80
%endmacro

%macro SWAP 2
    push %1
    push %2
    pop %1
    pop %2
%endmacro

%macro DIV_EAX 1
    push esi
    mov edx, 0
    mov esi, %1
    div esi
    pop esi
%endmacro

%macro DIV 2
    mov eax, %1
    DIV_EAX %2
    mov %1, eax
%endmacro

%macro MUL_EAX 1
    mov edx, %1
    mul edx
%endmacro

%macro MUL 2
    mov eax, %1
    MUL_EAX %2
    mov %1, %2
%endmacro

%macro PUSH_ALL 0
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
%endmacro

%macro POP_ALL 0
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
%endmacro
