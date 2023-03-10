format ELF64

public exit

section ".exit" executable
exit:
  xor eax, eax
  inc rax
  xor ebx, ebx
  int 0x80
