

#operating system detection
ifeq ($(OS),Windows_NT)
    uname_S := Windows
else
    uname_S := $(shell uname -s)
endif

ifeq ($(uname_S), Windows)
    SHARED=-shared
    TARGET=-o positronickernel.dll
endif
ifeq ($(uname_S), Linux)
    SHARED=-shared
    TARGET=-o libpositronickernel.so
endif
ifeq ($(uname_S), Darwin)
    SHARED=-dynamiclib
    TARGET=-lpositronickernel
endif

CC=cc
LINKER=cc
OFILES=mullinsim.o posit_conversions.o
NAME=mullin_8row_c_wrapper

%.o: %.cpp
	g++ -fpic -c -o $@ $<

build: $(OFILES)
	cd obj_dir && make -f Vmullin_8row_c_wrapper.mk
	$(LINKER) -Wall $(SHARED) $(OFILES) $(TARGET)

.PHONY: clean
clean:
	-rm *.o
	-rm *.so
	-rm obj_dir/*.o
	-rm obj_dir/*.a
