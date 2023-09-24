FILENAME=asmsort

$(FILENAME): $(FILENAME).asm
	nasm -f elf $(FILENAME).asm
	ld -m elf_i386 -s -o $(FILENAME) $(FILENAME).o
	rm $(FILENAME).o
