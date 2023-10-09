TARGET=asmsort

$(TARGET): $(TARGET).asm
	nasm -f elf $(TARGET).asm
	ld -m elf_i386 -s -o $(TARGET) $(TARGET).o
	rm $(TARGET).o

clean:
	rm -f $(TARGET)

.PHONY: clean
