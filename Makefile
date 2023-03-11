NAME = main
LANG = asm
CC = fasm
LD_FLAGS = -o
LIB_DIR = asm_lib
LIBS = $(wildcard $(LIB_DIR)/*.$(LANG))
LIBS_OBJ = $(patsubst %.$(LANG), %.o, $(LIBS))

.PHONY: default build run
default: build run
$(LIB_DIR)/%.o: $(LIB_DIR)/%.$(LANG)
	$(CC) $<
build: $(NAME).$(LANG) $(LIBS_OBJ)
	@$(CC) $<
	@ld $(NAME).o $(LIBS_OBJ) $(LD_FLAGS) $(NAME)
	@rm $(NAME).o
run: $(NAME)
	./$<
