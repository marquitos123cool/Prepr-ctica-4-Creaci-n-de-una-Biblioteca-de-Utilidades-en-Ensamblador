section .text
global convert_to_string

convert_to_string:
  mov rsi, rdi            ; RDI es ahora nuestro puntero al final del buffer
  add rdi, 19             ; Asumimos que el buffer tiene al menos 20 bytes
  mov byte [rdi], 0       ; Terminador null para la cadena ASCII

  mov rcx, 10             ; Establecer el divisor para la conversión

convert_loop:
  dec rdi
  xor rdx, rdx            ; Limpiar RDX ya que DIV usa RDX:RAX
  div rcx                 ; Dividir RAX por 10, resultado en RAX, resto en RDX
  add dl, '0'             ; Convertir el dígito a ASCII
  mov [rdi], dl           ; Escribir el dígito ASCII

  test rax, rax           ; Verificar si hemos terminado
  jnz convert_loop        ; Si no, continuar el bucle

  ; Ajustar RSI para apuntar al inicio de la cadena convertida
  ; inc rdi
  mov rsi, rdi

  ret
