format ELF64

public exit

section ".exit" executable
exit:
  xor ax, ax
  inc ax
  xor bx, bx
  int 0x80
