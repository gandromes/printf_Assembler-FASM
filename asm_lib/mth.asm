format ELF64

public gcd
public fibonacci
public factorial

section ".gcd" executable
gcd:
  push rbx
  push rdx
    .next_iter:
      cmp rbx, 0
      je .close
      xor edx, edx
      div rbx
      push rbx
      mov rbx, rdx
      pop rax
      jmp .next_iter
  .close:
    pop rdx
    pop rbx
    ret

section ".fibonacci" executable
fibonacci:
  push rbx
  push rcx
  xor ebx, ebx
  xor ecx, ecx
  cmp rax, 0
  jle .close
  inc ecx
    .next_iter:
      cmp rax, 1
      jle .close
      push rcx
      add rcx, rbx
      pop rbx
      dec rax
      jmp .next_iter
  .close:
    mov rax, rcx
    pop rbx
    pop rcx
    ret

section ".factorial" executable
factorial:
  push rbx
    mov rbx, rax
    xor eax, eax
    inc eax
      .next_iter:
        cmp rbx, 1
        jle .close
        mul rbx
        dec rbx
        jmp .next_iter
  .close:
    pop rbx
    ret
