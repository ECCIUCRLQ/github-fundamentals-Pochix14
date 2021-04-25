;definicio de segmento de datos
section .data
    mensajeH:    db "Hola mundo", 10
    tamanoH:     equ $ - mensajeH
    mensajeA:    db "Adios mundo", 10
    tamanoA:     equ $ - mensajeA

    num:         dd 0

    ;Cada digito hexadecimal se representa con 4 bits, o sea cada 2 caben en un byte
    ;Ej: x: dw 0x0C -> 00 0C //Solo ocupa un byte, lo demas se llena de 0's

;definicion de codigo
section .text
global _start
_start:
        mov ecx, [num]  ;Si se pone en [] se esta poniendo el valor al que apunta num
                        ;Si se pone sin [], se envia la direccion de memoria (el inicio) 
        cmp ecx, 0  ;cmp es comparar, compara el primero con el segundo, segun el resultado, modifica los EFLAGS
        je  hola    ;je es un jump (en este caso si es igual), va hacia la etiqueta 'hola', hay varios tipos de jump (ver final)
        ;Esto va siendo el else del salto anterior
        mov rsi, mensajeA
        mov rdx, tamanoA
        call imprimir   ;El call hace el llamado a la etiqueta

        jmp salir   ;Este es un salto para que no se meta a ejecutar lo que hay en el hola

    hola:           ;Etiqueta para el jump, pero no delimita la ejecucion del codigo
        mov rsi, mensajeH
        mov rdx, tamanoH
        call imprimir

    imprimir:       ;Esta etiqueta es como crear un metodo en alto nivel
        mov rax, 1
        mov rdi, 1
        syscall
        ret     ;por cada call se hace un ret, este devuelve el control a la instruccion 
                ;siguiente de la fue llamado

    salir:          ;Etiqueta para la salida, del jump antes del hola
        mov rax, 60 ;el 60 es el que le devuelve el control al SO
        mov rdi, 0  ;este es el valor del return
        syscall

        ;-RBP y RSP son punteros a la pila, el RSP apunta al tope de la pila y RBP apunta a la base
        ;-Los registros CS, DS, ES, GS, FS y SS son puntero a segmentos de memoria (datos, codigo, pila, segmentos extra)
        ;Dependiendo de la arquitectura, estos se amoldan al tamano de la misma
        ;-FLAGS son banderas de la ALU, estas son las encargadas de la revision de errores (overflow por ejemplo)
        ;-SSEE, AVX, AVX-512 son otro set de instrucciones de 128, 256 y 512 bits respectivamente, no estan directamente conectados al ALU
        ;-little endian da vuelta a los numeros en memoria que esten definidos mayor en un byte (dw, dd, dq)
        ;cuando se recupera un numero guardado con little endian, este vuelve a dar vuelta (queda normal)
        ;Tipos de jumps:
        ;   je: jump si son iguales
        ;   jne: jump si son diferentes
        ;   jl: jump si primero es menor
        ;   jle: jump si primero es menor o igual
        ;   jg: jump si primero es mayor
        ;   jpe: jump si primero es mayor o igual
        ;   jb: jump si primero es menor (sin signo)
        ;   jbe: jump si primero es menos o igual (sin signo)
        ;   ja: jump si primero es mayor (sin signo)
        ;   jae: jump si primero es mayor o igual (con signo)