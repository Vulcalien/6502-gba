# Vulcalien's GBA Makefile
#
# Made for the 'gcc' compiler

# === DETECT OS ===
ifeq ($(OS),Windows_NT)
	CURRENT_OS := WINDOWS
else
	CURRENT_OS := UNIX
endif

# ========= EDIT HERE =========
OUT_FILENAME := 6502

SRC_DIR := src
OBJ_DIR := obj
BIN_DIR := bin

SRC_SUBDIRS := 6502 6502/memory \
               devices

ifeq ($(CURRENT_OS),UNIX)
	CC      := arm-none-eabi-gcc
	AS      := arm-none-eabi-as
	OBJCOPY := arm-none-eabi-objcopy

	EMULATOR := mgba-qt
else ifeq ($(CURRENT_OS),WINDOWS)
	CC      :=
	AS      :=
	OBJCOPY :=

	EMULATOR :=
endif

ASFLAGS  := -mcpu=arm7tdmi -Iinclude

LDFLAGS := -Tlnkscript -nostartfiles
LDLIBS  :=
# =============================

ifeq ($(CURRENT_OS),UNIX)
	MKDIR      := mkdir
	MKDIRFLAGS := -p

	RM      := rm
	RMFLAGS := -rfv
else ifeq ($(CURRENT_OS),WINDOWS)
	MKDIR      := mkdir
	MKDIRFLAGS :=

	RM      := rmdir
	RMFLAGS := /Q /S
endif

# === OTHER ===
SRC := $(wildcard $(SRC_DIR)/*.s)\
       $(foreach DIR,$(SRC_SUBDIRS),$(wildcard $(SRC_DIR)/$(DIR)/*.s))
OBJ := $(SRC:$(SRC_DIR)/%.s=$(OBJ_DIR)/%.o)

OUT_ELF := $(BIN_DIR)/$(OUT_FILENAME).elf
OUT     := $(BIN_DIR)/$(OUT_FILENAME).gba

OBJ_DIRECTORIES := $(OBJ_DIR) $(foreach DIR,$(SRC_SUBDIRS),$(OBJ_DIR)/$(DIR))

# === TARGETS ===
.PHONY: all run build clean

all: build

run:
	$(EMULATOR) ./$(OUT)

build: $(OUT)

clean:
	@$(RM) $(RMFLAGS) $(BIN_DIR) $(OBJ_DIR)

$(OUT): $(OUT_ELF)
	$(OBJCOPY) -O binary $^ $@

$(OUT_ELF): $(OBJ_DIR)/crt0.o $(filter-out $(OBJ_DIR)/crt0.o,$(OBJ)) | $(BIN_DIR)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s | $(OBJ_DIRECTORIES)
	$(AS) $(ASFLAGS) -o $@ $<

$(BIN_DIR) $(OBJ_DIRECTORIES):
	$(MKDIR) $(MKDIRFLAGS) "$@"

-include $(OBJ:.o=.d)
