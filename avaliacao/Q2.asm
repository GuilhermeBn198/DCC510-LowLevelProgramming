; Autor: Guilherme Bernardo 2019004044
; Um programa que leia dois números inteiros de 1 byte e retorne a multiplicação desses dois números.
section .bss
    numero1 resb 4
    numero2 resb 4
section .text

	%include "lib.ioString"	
	%macro getInputString 2
      						; Semelhante à syscall sys_read, essa macro guarda uma string de até 1 bytes no endereço de %1, %1 e %2 são os argumentos dados à macro na chamada
      	push rax
      	push rdi

      	mov rax , 0 			; sys_read
      	mov rdi , 0 			; std_in
      	mov rsi, %1 			; endereço
      	mov rdx, %2 			; bytes alocados
      	syscall

     	   	;restaura os valores dos regs antes da syscall
      	pop rdi
		pop rax
    	%endmacro

    	%macro parseInputToInt 1 
		;parse do Input para inteiro sem sinal
      	lea rax, [%1 + 5]    		; c  arrega o endereço após o último byte do input
      	mov BYTE [rax],0    		; adiciona o caractere 0 (null) no fim do input
      	lea rdi,[%1]        		; carrega o endereço do input pra rdi (reg usado como argumento em call parse_uint)
        	call parse_uint        		; função de parse unsigned int advinda da biblioteca
    	%endmacro

	global _start:
	_start: 
		; chamadas da macro para input
    		getInputString numero1, 4
    		getInputString numero2, 4
    		; os parses guardam o número convertido em rax

    		parseInputToInt numero1   	; resultado vai pra rax
    		mov rbx, rax        		; primeiro numero vai pra rbx para não ser sobrescrito 
    		parseInputToInt numero2    	; resultado vai pra rax

		mul rbx

		call print_uint

		call exit
		
