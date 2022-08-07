TARGET=sieve.js
SRC:=main.cpp sieve.cpp

wasm: $(SRC)
	em++ $(SRC) -o $(TARGET) -Wall -Werror --std=c++17 -O3 --embed-file truth.txt

.PHONY: clean
clean:
	rm *.wasm *.js
