# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -O2

.PHONY: all test clean

# Default target
all: matchcapture

# Build matchcapture
matchcapture: main.o matchcapture.o
	$(CC) $(CFLAGS) -o $@ $^

# Build testcapture
testcapture: test.o matchcapture.o
	$(CC) $(CFLAGS) -o $@ $^

# Build and run tests
test: testcapture
	./testcapture

# Clean up
clean:
	rm -f *.o testcapture matchcapture
