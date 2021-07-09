#!/bin/bash
sudo apt-get update
sudo apt-get install python3 python3-pip pypy3 golang nodejs openjdk-11-jdk sbcl
python3 -m pip install cython matplotlib mkdocs-material

# emscripten
git clone https://github.com/emscripten-core/emsdk.git ~/emsdk
pushd ~/emsdk
./emsdk install latest
./emsdk activate latest
