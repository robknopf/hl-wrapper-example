# Makefile for building mylib.c as a shared library

# Compiler and flags
CC = gcc
CFLAGS = -shared -fPIC
SRC_DIR = src
OUT_DIR = bin
RUNTIME_BIN_DIR = ../../bin

# Hashlink:  Look for the git version first.  There is likely a way to use haxelib, but this'll do for now.
INC = $(HAXELIB_PATH)/hashlink/git/src $(HAXELIB_PATH)/hashlink/src

# Target names
TARGET_LIB = $(OUT_DIR)/mylib.hdll   # On Linux/macOS
# For Windows, change to: TARGET_LIB = $(OUT_DIR)/mylib.dll

# Source files
SRC_FILES = $(SRC_DIR)/mylib.c

# Build the shared library
all: ensure_dir $(TARGET_LIB) copy_to_runtime_bin

# Ensure the destination directory exists
ensure_dir:
	mkdir -p $(OUT_DIR)

# Ensure the destination directory exists
copy_to_runtime_bin:
	mkdir -p $(RUNTIME_BIN_DIR)
	cp $(TARGET_LIB) $(RUNTIME_BIN_DIR)

$(TARGET_LIB): $(SRC_FILES)
	$(CC) $(CFLAGS) $(INC:%=-I%) -o $@ $^

# Clean the build
clean:
	rm -f $(TARGET_LIB)
