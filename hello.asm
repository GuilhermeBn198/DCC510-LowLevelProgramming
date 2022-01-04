; hello_world.asm
; Author: Guilherme Bernardo
; Date: 03-jan-2021
global _start

section .text:
_start:
	mov eax, 0x4		;use the write syscall
	mov ecx, 1			  ;use stdout as the fd
	mov ecx, message	   ; use the message as the buffer
	mov edx, message_length	   ; and supply the length
	int 0x80			     ; invoke the syscall

	; now gracefully exit

	mov eax, 60 	   ;use the "exit"  syscall number
	mov ebx, 0
	int 0x80

section .data:
	message: db "hello world!", 0xA ;this "0xa" is equivalent to "\n" in another languages
	message_length equ $-message ;this 'ill specify the message length according to the bytes used in the message