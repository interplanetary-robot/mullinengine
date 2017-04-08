CC=cc
LINKER=cc
OFILES=mullinsim.o posit_conversions.o
NAME=mullin_8row_c_wrapper

.PHONY: verilog
verilog:
	cd obj_dir && make -f V$(NAME).mk

%.o: %.c $(DEPS)
	$(CC) -c -o -fpic $@ $<

build: $(OFILES) verilog
	$(CC) -Wall -shared $(OFILES) -o libpositronickernel.so

.PHONY: clean

clean:
	rm *.o
