CC = fasm
LIBS = asm_lib/fmt.asm asm_lib/sys.asm asm_lib/str.asm asm_lib/mth.asm
LIBS_OBJ = asm_lib/fmt.o asm_lib/sys.o asm_lib/str.o asm_lib/mth.o
.PHONY: default compile build run
default: build run
compile: ${LIBS}
	${CC} asm_lib/fmt.asm && ${CC} asm_lib/sys.asm && ${CC} asm_lib/str.asm && ${CC} asm_lib/mth.asm
build: main.asm ${LIBS_OBJ}
	fasm main.asm
	ld main.o ${LIBS_OBJ} -o main
run: main
	./main
