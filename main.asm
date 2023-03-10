format ELF64
public _start

include "asm_lib/fmt.inc"
include "asm_lib/sys.inc"

section ".data" writable
  fmt db "%s:\n\t%d %c 2 === %d\n\t%d %c%c 1 === %d\n", 0
  msg db "half(n)", 0

section ".text" executable
_start:
  mov rax, 3600
  mov rbx, 1800
  push rbx
  push ">"
  push ">"
  push rax
  push rbx
  push "/"
  push rax
  mov rax, msg
  push rax
  mov rax, fmt
  call print_f
  jmp exit

section ".print_f" executable
print_f:
  push rax
  push rbx
    mov rbx, 32
      .next_iter:
        cmp [rax], byte 0
        je .close
        cmp [rax], byte "%"
        je .special_char
        cmp [rax], byte '\'
        je .special_escape_char
        jmp .default_char
        .special_escape_char:
          inc rax
          cmp [rax], byte "n"
          je .print_empty_line
          cmp [rax], byte "t"
          je .print_tab
          cmp [rax], byte '\'
          je .print_back_slash_char
        .special_char:
          inc rax
          cmp [rax], byte "s"
          je .print_string
          cmp [rax], byte "d"
          je .print_number
          cmp [rax], byte "o"
          je .print_oct
          cmp [rax], byte "x"
          je .print_hex
          cmp [rax], byte "c"
          je .print_char
          cmp [rax], byte "%"
          je .print_percent
          jmp .next_step
        .print_empty_line:
          call print_empty_line
          jmp .next_step
        .print_tab:
          call print_tab
          jmp .next_step
        .print_back_slash_char:
          push rax
            mov rax, '\'
            call print_char
          pop rax
          jmp .next_step
        .print_string:
          push rax
            mov rax, [rsp+rbx]
            call print_string
          pop rax
          jmp .shift_stack
        .print_number:
          push rax
            mov rax, [rsp+rbx]
            call print_number
          pop rax
          jmp .shift_stack
        .print_oct:
          push rax
            mov rax, [rsp+rbx]
            call print_oct
          pop rax
          jmp .shift_stack
        .print_hex:
          push rax
            mov rax, [rsp+rbx]
            call print_hex
          pop rax
          jmp .shift_stack
        .print_char:
          push rax
            mov rax, [rsp+rbx]
            call print_char
          pop rax
          jmp .shift_stack
        .print_percent:
          push rax
            mov rax, "%"
            call print_char
          pop rax
          jmp .shift_stack
        .default_char:
          push rax
            mov rax, [rax]
            call print_char
          pop rax
          jmp .next_step
        .shift_stack:
          add rbx, 8
        .next_step:
          inc rax
          jmp .next_iter
  .close:
    pop rbx
    pop rax
    ret
