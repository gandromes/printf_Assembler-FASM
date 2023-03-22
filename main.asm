format ELF64
public _start

include "asm_lib/fmt.inc"
include "asm_lib/sys.inc"

section ".data" writable
  fmt db "%s:\n\tdec|> %d %c %d %s %d \thex|> %x %c %x %s %x \toct|> %o %c %o %s %o\n\tdec|> %d %s %d %s %d\thex|> %x %s %x %s %x\toct|> %o %s %o %s %o\n", 0
  title db "half(n)", 0
  strict_equal db "===", 0
  right_shifts db ">>", 0

section ".text" executable
_start:
  mov rax, 3600
  mov rbx, 1800
  mov rcx, 3

  .for:
    cmp rcx, 0   ;| condition
    je .then_for ;| i > 0
    dec rcx      ;| i--
      push rbx          ;| body
      push strict_equal ;|
      push 1            ;|
      push right_shifts ;|
      push rax          ;|
    jmp .for
  .then_for:
    cmp rcx, 3  ;| condition
    je .rof     ;| i < 3
    inc rcx     ;| i++
      push rbx           ;| body
      push strict_equal  ;|
      push 2             ;|
      push "/"           ;|
      push rax           ;|
    jmp .then_for
  .rof:

  push title
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
          je .print_default_escape_char
        .special_char:
          inc rax
          cmp [rax], byte "s"
          je .print_string
          cmp [rax], byte "d"
          je .print_number
          cmp [rax], byte "b"
          je .print_bin
          cmp [rax], byte "o"
          je .print_oct
          cmp [rax], byte "x"
          je .print_hex
          cmp [rax], byte "c"
          je .print_char
          cmp [rax], byte "%"
          je .print_default_special_char
          jmp .next_step
        .print_empty_line:
          call print_empty_line
          jmp .next_step
        .print_tab:
          call print_tab
          jmp .next_step
        .print_default_escape_char:
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
        .print_bin:
          push rax
            mov rax, [rsp+rbx]
            call print_bin
          pop rax
          jmp .shift_stack
        .print_default_special_char:
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
