#!/bin/bash
sudo apt-get update -yq
sudo apt-get install -yq python3 python3-pip pypy3 golang nodejs openjdk-11-jdk sbcl luajit
sudo apt-get install -yq binutils git gnupg2 libc6-dev libcurl4 libedit2 libgcc-9-dev libpython2.7 libsqlite3-0 libstdc++-9-dev libxml2 libz3-dev pkg-config tzdata zlib1g-dev
python3 -m pip install numba cython matplotlib mkdocs-material
python3 -m pip install --upgrade pip

# emscripten
git clone https://github.com/emscripten-core/emsdk.git ~/emsdk
pushd ~/emsdk
./emsdk install latest
./emsdk activate latest

# swift
wget -q https://download.swift.org/swift-5.5.1-release/ubuntu2004/swift-5.5.1-RELEASE/swift-5.5.1-RELEASE-ubuntu20.04.tar.gz
tar -xzf swift-5.5.1-RELEASE-ubuntu20.04.tar.gz -C ~
echo "PATH=~/swift-5.5.1-RELEASE-ubuntu20.04/usr/bin:$PATH" >> ~/.bashrc
