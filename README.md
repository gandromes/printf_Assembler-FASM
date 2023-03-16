# About the project:
- ***This repository was created in order to demonstrate the skills of working with low-level Assembler code (FASM) and the ability to implement basic functions using the example of `printf`***

## Example:

**Input**
```bash
  fmt db "%s:\n\t%d %c %d %s %d\n\t%d %c%c %d %s %d\n", 0
  title db "half(n)", 0
  strict_equal db "===", 0
```

**CODE**
```bash
  mov rax, 3600
  mov rbx, 1800

  push rbx
  push strict_equal
  push 1
  push ">"
  push ">"
  push rax
  push rbx
  push strict_equal
  push 2
  push "/"
  push rax
  push title
  mov rax, fmt
  call print_f
  jmp exit
```

**Output**
```bash
half(n):
    3600 / 2 === 1800
    3600 >> 1 === 1800
```

## Implement libs:
  1. **asm_lib/`fmt.asm`** - this library implements functions to output something (print_*)
    ### Implement functions from `fmt.asm`:
      1.1 **print_number** - we divide the number by 10 as long as possible, add the character "0" to the remainder of the division, which means converting the number n (0-9) to the character n ("0"-"9") and put it on the stack, as soon as the original number cannot be divided, we extract n("0"-"9") from the stack, one by one and execute print_char().
      1.2 **print_oct** - identical to print_number, except that we divide the original number by 8 as long as possible.
      1.3 **print_hex** - it is similar to print_number except we divide the original number not by 10 but by 16 and if the remainder goes beyond the range (0-9), then we add "A" and not "0" to it.
      1.4 **print_string** - executes length_string, puts its response in the rdx register and moves the source string to the desired rcx register.
      1.5 **print_char** - identical to print_string, except that initially strictly 1 byte is allocated for the length, which is located in the rdx register.
      1.6 **print_empty_line** - identical to print_char, except that we pass 0xA (newline character)to the rcx register.
      1.7 **print_tab** - identical to print_string, except that the original value in the rcx register is strictly set to "    ".
