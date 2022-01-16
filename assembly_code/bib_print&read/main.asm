section .data
message: db "Salve professor!!!", 10, 0
str1: db 'teste1',0
str2: db 'teste1',0
arg1: db 'copiar',10,0
arg2: times '1' db  66
num: db '301'
negNum: db '-540'

section .text
%include "lib.ioString"
global _start
 ;testing all the functions in lib.ioString
_start:
	;print string
	mov rdi, message 
	call print_string
	;print unsigned int

	mov rax, 09410948
	call print_uint
	;print unsigned int

	mov rdi, -2012901
	call print_int
	;parse an int and print it

	mov rdi, num
	call parse_uint
	mov rdi,rax
	call print_uint
	;parse an int and print it

	mov rdi, negNum
	call parse_int
	mov rdi,rax
	call print_int
	;parse an int and print it

	mov rdi, str1
	mov rsi, str2
	call string_equals
	;compare strings

	mov rdi, rax
	call print_uint

	mov rdi, arg1
	mov rsi, arg2
	call string_copy
	;copy strings
	mov rdi, arg2 
	call print_string
	;print string

	call exit