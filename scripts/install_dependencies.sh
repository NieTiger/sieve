#!/bin/bash
sudo apt-get update -yq

# Build tools for C++
sudo apt-get install -y binutils git build-essential

# Python3, pypy3, numba, cython
sudo apt-get install -y python3 python3-pip pypy3 
python3 -m pip install --upgrade pip
python3 -m pip install numba cython 

# golang, nodejs, java, common lisp, luajit
sudo apt-get install -y golang nodejs openjdk-11-jdk sbcl luajit

# emscripten
git clone https://github.com/emscripten-core/emsdk.git ~/emsdk
pushd ~/emsdk
./emsdk install latest
./emsdk activate latest

# swift
wget -q https://download.swift.org/swift-5.6.2-release/ubuntu2004/swift-5.6.2-RELEASE/swift-5.6.2-RELEASE-ubuntu20.04.tar.gz
tar -xzf swift-5.6.2-RELEASE-ubuntu20.04.tar.gz -C ~
echo "PATH=~/swift-5.6.2-RELEASE-ubuntu20.04/usr/bin:$PATH" >> ~/.bashrc

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# build script and docs
python3 -m pip install matplotlib mkdocs-material
