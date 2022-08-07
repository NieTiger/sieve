#!/bin/bash
cmake -B build >/dev/null 2>&1
cmake --build build -j >/dev/null 2>&1
./build/sieve
echo C++
g++ --version
