format ELF64

public length_string

section ".length_string" executable
length_string:
  push rcx
    xor ecx, ecx
      .next_iter:
        cmp [rax + rcx], byte 0
        je .close
        inc rcx
        jmp .next_iter
  .close:
    mov rax, rcx
    pop rcx
    ret
