format ELF64

public print_number
public print_bin
public print_oct
public print_hex
public print_string
public print_char
public print_empty_line
public print_bytes
public print_tab

include "str.inc"

section ".bss" writable
  _bss_tab db "    ", 0
  _bss_char rb 1

section ".print_number" executable
print_number:
  push rax
  push rbx
  push rcx
  push rdx
    xor ecx, ecx
      .next_iter:
        mov rbx, 10
        xor edx, edx
        div rbx
        add rdx, "0"
        push rdx
        inc rcx
        cmp rax, 0
        je .print_iter
        jmp .next_iter
      .print_iter:
        cmp rcx, 0
        je .close
        pop rax
        call print_char
        dec rcx
        jmp .print_iter
  .close:
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

section ".print_bin" executable
print_bin:
  push rax
  push rbx
  push rcx
  push rdx
    xor ecx, ecx
      push rax
        mov rax, "0"
        call print_char
        mov rax, "b"
        call print_char
      pop rax
      .next_iter:
        mov rbx, 2
        xor edx, edx
        div rbx
        add rdx, "0"
        push rdx
        inc rcx
        cmp rax, 0
        je .print_iter
        jmp .next_iter
      .print_iter:
        cmp rcx, 0
        je .close
        pop rax
        call print_char
        dec rcx
        jmp .print_iter
  .close:
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

section ".print_oct" executable
print_oct:
  push rax
  push rbx
  push rcx
  push rdx
    xor ecx, ecx
      push rax
        mov rax, "0"
        call print_char
      pop rax
      .next_iter:
        mov rbx, 8
        xor edx, edx
        div rbx
        add rdx, "0"
        push rdx
        inc rcx
        cmp rax, 0
        je .print_iter
        jmp .next_iter
      .print_iter:
        cmp rcx, 0
        je .close
        pop rax
        call print_char
        dec rcx
        jmp .print_iter
  .close:
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

section ".print_hex" executable
print_hex:
  push rax
  push rbx
  push rcx
  push rdx
    xor ecx, ecx
      push rax
        mov rax, "0"
        call print_char
        mov rax, "x"
        call print_char
      pop rax
      .next_iter:
        mov rbx, 16
        xor edx, edx
        div rbx
        cmp rdx, 10
        jl .is_number
        jmp .is_alpha
        .is_number:
          add rdx, "0"
          jmp .next_step
        .is_alpha:
          sub rdx, 10
          add rdx, "A"
          jmp .next_step
        .next_step:
          push rdx
          inc rcx
          cmp rax, 0
          je .print_iter
          jmp .next_iter
      .print_iter:
        cmp rcx, 0
        je .close
        pop rax
        call print_char
        dec rcx
        jmp .print_iter
  .close:
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

section ".print_string" executable
print_string:
  push rax
  push rbx
  push rcx
  push rdx
    mov rcx, rax
    call length_string
    mov rdx, rax
    mov rax, 4
    xor ebx, ebx
    inc ebx
    int 0x80
  pop rdx
  pop rcx
  pop rbx
  pop rax
  ret

section ".print_char" executable
print_char:
  push rax
  push rbx
  push rcx
  push rdx
    mov [_bss_char], al
      mov rax, 4
      xor ebx, ebx
      inc ebx
      mov rcx, _bss_char
      xor edx, edx
      inc edx
      int 0x80
  pop rdx
  pop rcx
  pop rbx
  pop rax
  ret

section ".print_empty_line" executable
print_empty_line:
  push rax
    xor eax, eax
    mov al, 0xA
    call print_char
  pop rax
  ret

section ".print_tab" executable
print_tab:
  push rax
    xor eax, eax
    mov rax, _bss_tab
    call print_string
  pop rax
  ret

section ".print_bytes" executable
print_bytes:
  push rax
  push rbx
  push rcx
  push rdx
    mov rdx, rax
    xor ecx, ecx
    mov rax, "["
    call print_char
    mov rax, " "
    call print_char
      .next_iter:
        cmp rcx, rbx
        je .close
        xor eax, eax
        mov al, [rdx+rcx]
        call print_number
        mov al, " "
        call print_char
        inc rcx
        jmp .next_iter
  .close:
    mov rax, "]"
    call print_char
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret
