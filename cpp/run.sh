#!/bin/bash
cmake -B build | tail -n +90
cmake --build build -j | tail -n +90
./build/sieve
echo C++
g++ --version

source ~/emsdk/emsdk_env.sh > /dev/null
make wasm
node sieve.js
echo C++ wasm
em++ --version
