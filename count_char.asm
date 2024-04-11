section .text
global count_char

; Función count_char: Cuenta los caracteres en un buffer de texto hasta un terminador nulo o un límite dado.
; Argumentos:
;   rdi: dirección del buffer de entrada
;   rsi: longitud máxima a contar
; Retorno:
;   rax: número de caracteres contados, sin incluir el terminador nulo

count_char:
  xor rax, rax    ; Contador de caracteres a 0

count_loop:
  cmp rax, rsi    ; Verificar si hemos alcanzado la longitud máxima
  jge done        ; Si rax mayor o igual a rsi, terminamos
  mov rcx, rax    ; Mover contador a rcx para usarlo como índice
  cmp byte[rdi + rax], 0  ; Comprobar si el carácter actual es terminador nulo
  je done         ; Si es terminador nulo, hemos terminado
  cmp byte[rdi + rcx], 0xA    ; Comprobar si el carácter actual es un salto de línea
  je skip_character   ; Si es salto de línea, no lo contamos
  inc rax         ; Incrementar contador de caracteres
skip_character:
  inc rcx         ; Incrementar el índice rcx
  cmp rcx, rsi    ; Comprobar si rcx ha alcanzado el límite
  jl count_loop   ; si no, continuar el bucle
  jmp done        ; si sí, ir a done

done:
  ret             ; Retorna con el contador en rax