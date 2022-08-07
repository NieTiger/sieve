#!/bin/bash
source ~/emsdk/emsdk_env.sh >/dev/null 2>&1
make wasm  >/dev/null 2>&1
node sieve.js
echo C++ wasm
em++ --version
