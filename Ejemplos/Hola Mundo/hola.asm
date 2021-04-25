;definicio de segmento de datos
section .data
    ; db = 1 byte, dw = 2 bytes, dd = 4 bytes y dq = 8 bytes
    ; db, dw, dd o dq son los tamanos donde se van a guardar las variables
    mensaje:    db "Hola mundo", 10 ;ese 10 representa el cambio de linea, al ponerlo hay que aumentar tamano
                                    ; despues de ese 10 se pueden agregar mas cadenas, ya que solo simboliza cambio de linea
                                    ;Exe: db "Hola mundo", 10, "Adios mundo", 10, se puede poner en ascii tambien (10 es en ascii)
    tamano:     equ $ - mensaje ;$ es la posicion actual en la memoria
                                ;equ para decirle que es constante

;definicion de codigo
section .text
global _start ;esto hace que el 'start' sea global y el SO lo pueda ver
_start:
        ;instrucion destino, fuente: asi se leen las lineas de ASM
        ;mov rsi, mensaje: copia la direccion de memoria donde esta Hola mundo, es un puntero al primer caracter
        ;mov rda, 10: esto hace que una vez en la direccion del primer caracter, se vaya moviendo la cantidad que dice tamano
        ;total de tamano de la hilera
        mov rax, 1  ;imprimir algo 
        mov rdi, 1  ;en salida estandar
        mov rsi, mensaje
        mov rdx, tamano
        syscall     ;esto llama(interrumpe) al SO para hacer algo, ese algo lo determina el rax

        mov rax, 60 ;el 60 es el que le devuelve el control al SO
        mov rdi, 0  ;este es el valor del return
        syscall

        ;En 8 bits caben numeros en 0 y 255, sin signo, -127 y 128 con signo
        ;bit menos significativo (mas a la derecha) es el al, el penultimo es el ah (al=low, ah=high)
        ;a; y ah son de 8 bits, y en conjunto los 16 bits se les llama ax
        ;para los de 32 bits, sigue el al, ah y por ser de 32 se llama eax
        ;en los de 64 bits siguen el al,ah, ax, eax y finalmente todo el conjunto es rax
        ;rax, rbx, rcx y rdx tienen el conjunto de 64, 32, 16 y 8 bits
        ;move rax, ecx NO es valido ya que tienen que ir de acuerdo a tipo (eax con ebx por ejemplo)
        ;O en su defecto, lo que se asigna debe caber en el destino mov ax, 500 (mov ah, 500 esta MAL)