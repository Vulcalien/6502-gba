all: bin/out.o65 move-to-bin

SRC := $(wildcard src/*.s65)
OBJ := $(SRC:src/%.s65=obj/%.o65)

bin/out.o65: $(OBJ) | bin
	ld65 -C sbc.cfg -o $@ $^

obj/%.o65: src/%.s65 | obj
	ca65 -o $@ $<

obj bin:
	mkdir $@

clean:
	rm -rf obj bin

move-to-bin:
	cp bin/out.o65 ../../bin/6502.sav
