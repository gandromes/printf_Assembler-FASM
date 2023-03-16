# About the project:
- ***This repository was created in order to demonstrate the skills of working with low-level Assembler code (FASM) and the ability to implement basic functions using the example of `printf`***

## Example:

**Input**
```asm
  fmt db "%s:\n\t%d %c %d %s %d\n\t%d %c%c %d %s %d\n", 0
  title db "half(n)", 0
  strict_equal db "===", 0
```

**CODE**
```asm
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
```java
half(n):
    3600 / 2 === 1800
    3600 >> 1 === 1800
```

# About the project:
- ***This repository was created in order to demonstrate the skills of working with low-level Assembler code (FASM) and the ability to implement basic functions using the example of `printf`***

  1    . **asm_lib/`fmt.asm`** - this library implements functions to output something (print_*):
    - **print_number** - we divide the number by 10 as long as possible, add the character "0" to the remainder of the division, which means converting the number n (0-9) to the character n ("0"-"9") and put it on the stack, as soon as the original number cannot be divided, we extract n("0"-"9") from the stack, one by one and execute print_char().
    - **print_bin** - identical to print_number, except that we divide the original number by 2 as long as possible.
    - **print_oct** - identical to print_number, except that we divide the original number by 8 as long as possible.
    - **print_hex** - it is similar to print_number except we divide the original number not by 10 but by 16 and if the remainder goes beyond the range (0-9), then we add "A" and not "0" to it.
    - **print_string** - executes length_string, puts its response in the rdx register and moves the source string to the desired rcx register.
    - **print_char** - identical to print_string, except that initially strictly 1 byte is allocated for the length, which is located in the rdx register.
    - **print_empty_line** - identical to print_char, except that we pass 0xA (newline character)to the rcx register.
    - **print_tab** - identical to print_string, except that the original value in the rcx register is strictly set to tab (4 whitespace).
    - **print_bytes** - this function takes a tuple of numbers and the number of elements in it, then goes through each number and calls print_number on it, increments the counter and this cycle ends only when the counter reaches the number of elements in the tuple
  2    . **"asm_lib/`str.asm`"** - this library implements functions to work with strings:
    - **length_string** - we go along the original string until we reach 0 bytes (the end of the string), incrementing the counter, at the end we return it
    - **number_to_string** - we create a counter and divide the number by 10 each time, add "0" to the remaining n(0-9), we get n("0"-"9"), put it on the stack, create a counter 2 from 0 to the value of the first counter, take n("0"-"9") from the stack and place it at the source address plus the offset in the form of counter2 and increase the counter when counter2 is equal to the first counter, this means that you need to put the end of line character (byte 0)
    - **string_to_number** - we go along the line, increment the counter, while subtracting the character "0" from n ("0"-"9"), thus, we get a number that we subsequently put on the stack. Let's create a counter2, which will correspond to the value 0 going up to the first counter, then take a number from the stack and multiply it by 10, then multiply this number by the value of counter2 (exmp: "413" == 4 * 10 * 3 + 1 * 10 * 2 + 3 * 10 * 1)
  3    . **"asm_lib/`mth.asm`"** - this library implements mathematical functions:
    - **gcd** - this function finds the greatest common divisor according to the Euclid algorithm
    - **fibonacci** - this function calculates the n number fibonacci using only a loop without the stack
    - **factorial** - this function calculates the n number factorial using very ez algoritm in loop
  4    . **"asm_lib/`sys.asm`"** - this library implements system calls:
    - **exit** - this function passes the necessary parameters to the registers to terminate the program and causes a system interrupt
