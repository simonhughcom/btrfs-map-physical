OBJECTS = btrfs-map-physical
SRC_PREFIX := ./src
CC=gcc
CFLAGS=-O2

## all : Compile all
all: $(OBJECTS)

$(OBJECTS): %: $(SRC_PREFIX)/%.c
	$(CC) $(CFLAGS) $< -o $@

## clean: remove compiled files
clean:
	rm -rf $(OBJECTS)

## variables : Print variables.
.PHONY: variables
variables:
	@echo OBJECTS:      $(OBJECTS)
	@echo SRC_PREFIX:   $(SRC_PREFIX)
	@echo CC:           $(CC)
	@echo CFLAGS:       $(CFLAGS)

## help : Print this help message.
.PHONY: help
help: Makefile
	@sed -n 's/^## //p' $< | awk -F':' '{printf "%-30s: %s\n", $$1, $$2'}
