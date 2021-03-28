#!/bin/bash
uname=$(uname -a)

### python
cd py3

# python3
py3=$(python3 main.py)
echo python3: $py3 passes

# pypy3
pypy3=$(pypy3 main.py)
echo pypy3: $pypy3 passes

# cython3
./build_cython.sh > /dev/null
cython3=$(python3 main_cython.py)
echo cython3: $cython3 passes

cd ..

### golang
cd ./go
golang=$(go run *.go)
echo golang: $golang passes
cd ..

### nodejs
cd ./nodejs
nodejs=$(node main.js)
echo nodejs: $nodejs passes
cd ..

### lisp
cd ./lisp
sbcl=$(sbcl --script main.lisp)
echo "lisp (sbcl): $sbcl passes"
cd ..

### java
cd ./java
javac Main.java
java=$(java Main)
echo java: $java passes
cd ..

### cpp
cd ./cpp
make
cpp=$(./sieve)
echo cpp: $cpp passes
cd ..
