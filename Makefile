CC := gcc
RM := rm

CFLAGS :=
EXEEXT :=

# Since we explicitly generate the filename, we're responsible for
# manually setting the filename.
# Note that OS is set by Windows, not by make, so it's not available
# on other platforms.
ifeq ($(OS), Windows_NT)
	EXEEXT := .exe
else
#	On Unix-based OSs, we can check uname -s to find out what we're running on
	UNAME_S := $(shell uname -s)

#	If we're building under cargo-dist, we may be cross-compiling;
#	check cargo-dist's CARGO_DIST_TARGET to find out what architecture
#	we're meant to build for, and add Apple's architecture flags to the
#	CFLAGS appropriately.
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
