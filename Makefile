NAME := space
CART := space.p8

.PHONY: all clean test web bin

all: web bin

clean:
	rm -r build

test:
	${PICO8} -p test -x $(CART) | tee /dev/tty | grep -q 'TEST SUCCESS'

web:
	mkdir -p build
	${PICO8} -export "-f build/$(NAME).html" $(CART)

bin:
	mkdir -p build
	${PICO8} -export "build/$(NAME).bin" $(CART)
