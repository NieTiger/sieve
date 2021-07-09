#!/bin/bash
make
./sieve
echo C++
g++ --version

echo
source ~/emsdk/emsdk_env.sh > /dev/null
make wasm
node sieve.js
echo C++ wasm
em++ --version
