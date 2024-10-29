section .data
    question db "Сейчас день? (Да/Нет): ", 0
    day_msg db "Добрый день", 0
    night_msg db "Добрый вечер", 0
    yes db "Да", 0
    no db "Нет", 0

section .bss
    answer resb 4

section .text
    global _start

_start:
    ; Выводим вопрос
    mov eax, 4
    mov ebx, 1
    mov ecx, question
    mov edx, 20
    int 0x80

    ; Читаем ответ
    mov eax, 3
    mov ebx, 0
    mov ecx, answer
    mov edx, 4
    int 0x80

    ; Сравниваем ответ с "Да"
    mov eax, answer
    mov ebx, yes
    call strcmp
    cmp eax, 0
    je day

    ; Сравниваем ответ с "Нет"
    mov eax, answer
    mov ebx, no
    call strcmp
    cmp eax, 0
    je night

day:
    ; Выводим "Добрый день"
    mov eax, 4
    mov ebx, 1
    mov ecx, day_msg
    mov edx, 11
    int 0x80
    jmp exit

night:
    ; Выводим "Добрый вечер"
    mov eax, 4
    mov ebx, 1
    mov ecx, night_msg
    mov edx, 12
    int 0x80

exit:
    ; Завершаем программу
    mov eax, 1
    xor ebx, ebx
    int 0x80

strcmp:
    ; Функция сравнения строк
    push ebp
    mov ebp, esp
    mov esi, [ebp+8]
    mov edi, [ebp+12]
    cld
    repe cmpsb
    mov eax, 0
    jne not_equal
    inc eax
not_equal:
    pop ebp
    ret