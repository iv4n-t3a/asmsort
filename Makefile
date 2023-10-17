ROOTDIR := $(shell pwd)
SRCDIR := $(ROOTDIR)/src
SRCEXT := asm
MAIN := main
SOURCES := $(shell find $(SRCDIR) -type f -name '*.$(SRCEXT)')

export ROOTDIR
export MAIN
export SOURCES

all: $(SOURCES)
	@make -C $(SRCDIR)

run:
	./$(MAIN)

clean:
	rm -f $(TARGET)

.PHONY: all, run, clean
