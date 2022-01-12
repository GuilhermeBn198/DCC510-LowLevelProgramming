
global _start

section .data
num: dq 190900023300

section .text

print_uint:
; division in 64bit save the quotient into rax and the reminder in rdx
  xor rcx, rcx
  mov r8, 10

  .print_uintloop:
    xor rdx, rdx ; clearing the register that is going to be used as holder for the reminder
    div r8
    add dl, 0x30; make the reminder printable in ascii conversion 0x30 is '0'
    dec rsp ; reduce one byte from the address placed in rsp (freeing one byte of memory)
    mov [rsp], dl; pour one byte into the address pointed
    inc rcx;
    test rax, rax
    jnz .print_uintloop

  .print_chars_on_stack:
    xor rax, rax
    mov rsi, rsp;
    mov rdx, rcx
    push rcx
    mov rax, 1
    mov rdi, 1
    syscall; rsi e rdx are respectively buffer starting point and length in byte
          ; the syscall is going to look at what is in memory at the address loaded in rsi (BE CAREFULL) and not at the content of rdi
    pop rcx
    add rsp, rcx; when printed we can free the stack
    call print_newline
  ret

print_newline:
  push 10
  mov rax, 1   ; identificador da syscall 'write'
  mov rdi, 1   ; descritor do arquivo stdout
  mov rsi, rsp ; local de onde os dados são obtidos
  mov rdx, 1   ; quantidade de bytes a ser escrita
  syscall
  pop rax
  xor rax, rax
  ret

_start:
  mov rax, [num]
  call print_uint
  mov rax, 60
  syscall