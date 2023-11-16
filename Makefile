CC := gcc
RM := rm

CFLAGS :=
EXEEXT :=

ifeq ($(OS), Windows_NT)
	EXEEXT := .exe
else
	UNAME_S := $(shell uname -s)

	ifeq ($(UNAME_S), Darwin)
		ifneq (,$(findstring x86_64,$(CARGO_DIST_TARGET)))
			CFLAGS += -arch x86_64
		endif
		ifneq (,$(findstring aarch64,$(CARGO_DIST_TARGET)))
			CFLAGS += -arch arm64
		endif
	endif
endif

all: main$(EXEEXT)

main$(EXEEXT):
	$(CC) main.c $(CFLAGS) -o main$(EXEEXT)

clean:
	$(RM) -f main$(EXEEXT)

.PHONY: all clean
