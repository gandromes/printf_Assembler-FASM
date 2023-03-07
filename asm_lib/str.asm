format ELF64

public string_to_number
public number_to_string
public length_string

section ".string_to_number" executable
string_to_number:
  push rbx
  push rcx
  push rdx
    xor ebx, ebx
    xor ecx, ecx
      .next_iter:
        mov cl, [rax+rbx]
        cmp cl, byte 0
        je .next_step
        sub cl, "0"
        inc rbx
        push rcx
        jmp .next_iter
      .next_step:
        xor ecx, ecx
        inc ecx
        xor eax, eax
      .to_number:
        cmp rbx, 0
        je .close
        pop rdx
        imul rdx, rcx
        add rax, rdx
        imul rcx, 10
        dec rbx
        jmp .to_number
  .close:
    pop rdx
    pop rcx
    pop rbx
    ret

section ".number_to_string" executable
number_to_string:
  push rax
  push rbx
  push rcx
  push rdx
  push rsi
    mov rsi, rcx
    dec rsi
    xor ecx, ecx
      .next_iter:
        push rbx
        mov rbx, 10
        xor edx, edx
        div rbx
        pop rbx
        add rdx, "0"
        push rdx
        inc rcx
        cmp rax, 0
        je .next_step
        jmp .next_iter
      .next_step:
        mov rdx, rcx
        xor ecx, ecx
      .to_string:
        cmp rcx, rsi
        je .pop_iter
        cmp rcx, rdx
        je .null_char
        pop rax
        mov [rbx + rcx], rax
        inc rcx
        jmp .to_string
      .pop_iter:
        cmp rcx, rdx
        je .close
        pop rax
        inc rcx
        jmp .pop_iter
      .null_char:
        mov rsi, rdx
  .close:
    mov [rbx + rsi], byte 0
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

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
    mov rdx, rcx
    pop rcx
    ret

