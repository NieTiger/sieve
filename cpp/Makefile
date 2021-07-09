all: main.cpp
	@g++ -Wall -Werror --std=c++17 -Ofast main.cpp -o sieve

wasm: main.cpp
	@em++ main.cpp -o sieve.js -Wall -Werror --std=c++17 -O3 --embed-file truth.txt
