;definicio de segmento de datos
section .data
    ; db, dw, dd o dq son los tamanos donde se van a guardar las variables
    mensaje:    db "Hola mundo", 10 ;ese 10 representa el cambio de linea, al ponerlo hay que aumentar tamano
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