section .data
    input db "hello world", 0
    output db 12 dup(0)

section .text
    global _start

_start:
    mov esi, input
    mov edi, output

convert:
    lodsb
    cmp al, 0
    je done
    cmp al, 'a'
    jb store
    cmp al, 'z'
    ja store
    sub al, 32

store:
    stosb
    jmp convert

done:
    ; Выводим результат
    mov eax, 4
    mov ebx, 1
    mov ecx, output
    mov edx, 11  ; Длина строки "HELLO WORLD"
    int 0x80
    ; Завершаем программу
    mov eax, 1
    xor ebx, ebx
    int 0x80
