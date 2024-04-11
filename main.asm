section .bss
user_input resb 256       ; Reserva un buffer de 256 bytes para la entrada del usuario.
input_length resb 1       ; Para almacenar la longitud de la entrada del usuario.
output_buffer resb 20     ; Buffer para la cadena de la salida.


section .data
prompt db 'Ingresa una cadena de texto: ', 0
prompt_len equ $ - prompt
msg_count db 'Numero de caracteres: ', 0
msg_count_len equ $ - msg_count
newline db 0xA            ; Representación de salto de línea

section .text
global _start
extern count_char, convert_to_string

_start:
  ; Imprimir mensaje de solicitud de entrada.
  mov rax, 1
  mov rdi, 1
  mov rsi, prompt
  mov rdx, prompt_len
  syscall

  ; Leer entrada del usuario.
  mov rax, 0
  mov rdi, 0
  mov rsi, user_input
  mov rdx, 256
  syscall

  ; Guardar la longitud de la entrada.
  mov [input_length], rax

  ; Preparar argumentos para count_char.
  mov rdi, user_input     ; Dirección del buffer de entrada.
  mov rsi, [input_length] ; Longitud de la entrada.
  call count_char        ; Llama a count_char

  ; El número de caracteres se devuelve en rax. Preparar para imprimir resultado.
  mov rdi, output_buffer  ; Inicio del buffer para almacenar la cadena numérica.
  call convert_to_string  ; Convierte rax a cadena ASCII.

  ; Imprimir Mensaje .
  mov rax, 1
  mov rdi, 1
  mov rsi, msg_count
  mov rdx, msg_count_len
  syscall

  ; Imprimir el número de caracteres.
  mov rax, 1
  mov rdi, 1
  mov rsi, output_buffer  ; La cadena convertida está en output_buffer.
  mov rdx, 20             ; Longitud máxima del buffer.
  syscall

  ; Imprimir salto de línea después del número.
  mov rax, 1
  mov rdi, 1
  mov rsi, newline        ; Dirección de la representación del salto de línea.
  syscall

  ; Terminar el programa.
  mov rax, 60
  xor rdi, rdi
  syscall
