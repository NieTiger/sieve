#!/bin/bash
cmake -B build
cmake --build build -j
./build/sieve
echo C++
g++ --version

source ~/emsdk/emsdk_env.sh > /dev/null
make wasm
node sieve.js
echo C++ wasm
em++ --version
