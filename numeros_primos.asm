;       ------ Equipo E ------
;           Integrantes:
; Escalante Tolentino Adamaris Jokabed
;   Hernandez Valencia Jose Manuel
;      Ramirez Ramirez Selene
;    Ubaldo Torres Fernanda Ximena

section .data
    prompt1 db "Es primo", 0xA, 0
    len1 equ $-prompt1
    prompt2 db "No es primo", 0xA, 0
    len2 equ $-prompt2
    
    ; La variable que contiene el número a verificar
    numero_a_verificar dd 3

section .text
    global _start

    print_str:
        mov eax, 4
        mov ebx, 1
        int 0x80
        ret

    Numero_Primo:
        push ebp
        mov ebp, esp
        sub esp, 4   ; Asignar 4 bytes para una variable local 'n'

        mov eax, [ebp+8] ; Cargar n del stack
        mov [ebp-4], eax ; Guardar n en la variable local

        ; caso particular n=1
        cmp eax, 1
        je .No_primo

        ; Bucle para probar divisores desde 2
        mov ecx, 2      ; ecx = i (el divisor)
    
    .bucle_primo:
        ; Condición de salida: si i*i > n, n es primo
        mov ebx, ecx
        imul ebx, ecx   ; ebx = i*i
        
        mov eax, [ebp-4] ; Restaurar n en eax
        cmp ebx, eax    
        ja .Es_primo
        
        ; Probar si n es divisible por i
        mov ebx, ecx    ; Mover i a ebx para la división
        xor edx, edx    ; Limpiar edx
        mov eax, [ebp-4] ; Restaurar n en eax antes de la división
        div ebx         ; n / i. El residuo se almacena en edx
        
        cmp edx, 0      ; Comprobar si el residuo es cero
        je .No_primo    ; Si es cero, no es primo
        
        inc ecx         ; i++
        jmp .bucle_primo

    ; etiquetas para el resultado
    .Es_primo:
        mov ecx, prompt1
        mov edx, len1
        call print_str
        jmp .Fin_Primo

    .No_primo:
        mov ecx, prompt2
        mov edx, len2
        call print_str

    .Fin_Primo:
        mov esp, ebp
        pop ebp
        ret

_start:
    push dword [numero_a_verificar]
    call Numero_Primo

    mov eax, 1
    xor ebx, ebx
    int 0x80
