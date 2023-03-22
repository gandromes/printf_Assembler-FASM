# About the project:
- ***This repository was created in order to demonstrate the skills of working with low-level Assembler code (FASM) and the ability to implement basic functions using the example of `printf`***

## Example:

**Input**
```asm
  fmt db "%s:\n\tdec|> %d %c %d %s %d \thex|> %x %c %x %s %x \toct|> %o %c %o %s %o\n\tdec|> %d %s %d %s %d\thex|> %x %s %x %s %x\toct|> %o %s %o %s %o\n", 0
  title db "half(n)", 0
  strict_equal db "===", 0
  right_shifts db ">>", 0
```

**CODE**
```asm
  mov rax, 3600
  mov rbx, 1800
  mov rcx, 3     ; i

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
```

**Output**
```java
half(n):
    dec|> 3600 / 2 === 1800     hex|> 0xE10 / 0x2 === 0x708     oct|> 07020 / 02 === 03410
    dec|> 3600 >> 1 === 1800    hex|> 0xE10 >> 0x1 === 0x708    oct|> 07020 >> 01 === 03410
```
## Implement libs:

1. **asm_lib/`fmt.asm`** - this library implements functions to output something (print_*):
    - **print_number** - we divide the number by 10 as long as possible, add the character "0" to the remainder of the division, which means converting the number n (0-9) to the character n ("0"-"9") and put it on the stack, as soon as the original number cannot be divided, we extract n("0"-"9") from the stack, one by one and execute print_char().
    - **print_bin** - identical to print_number, except that we divide the original number by 2 as long as possible.
    - **print_oct** - identical to print_number, except that we divide the original number by 8 as long as possible.
    - **print_hex** - it is similar to print_number except we divide the original number not by 10 but by 16 and if the remainder goes beyond the range (0-9), then we add "A" and not "0" to it.
    - **print_string** - executes length_string, puts its response in the rdx register and moves the source string to the desired rcx register.
    - **print_char** - identical to print_string, except that initially strictly 1 byte is allocated for the length, which is located in the rdx register.
    - **print_empty_line** - identical to print_char, except that we pass 0xA (newline character)to the rcx register.
    - **print_tab** - identical to print_string, except that the original value in the rcx register is strictly set to tab (4 whitespace).
    - **print_bytes** - this function takes a tuple of numbers and the number of elements in it, then goes through each number and calls print_number on it, increments the counter and this cycle ends only when the counter reaches the number of elements in the tuple
2. **"asm_lib/`str.asm`"** - this library implements functions to work with strings:
    - **length_string** - we go along the original string until we reach 0 bytes (the end of the string), incrementing the counter, at the end we return it
3. **"asm_lib/`sys.asm`"** - this library implements system calls:
    - **exit** - this function passes the necessary parameters to the registers to terminate the program and causes a system interrupt
