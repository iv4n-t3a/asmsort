all: $(SOURCES)
	nasm -f elf $(MAIN).asm
	ld -m elf_i386 -s -o $(ROOTDIR)/$(MAIN) $(MAIN).o
	rm $(MAIN).o

.PHONY: all
