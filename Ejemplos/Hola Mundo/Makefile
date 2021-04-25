APPNAME = hola_mejorado
ASM =nasm
AFLAGS =-f elf64

all:
	@echo "Ensamblando..."
	$(ASM) $(AFLAGS) -o $(APPNAME).o $(APPNAME).asm
	ld -o exe $(APPNAME).o

.PHONY: clean
clean:
	rm *.o exe

