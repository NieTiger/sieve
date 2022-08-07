#!/bin/bash
cargo build --release >/dev/null 2>&1
./target/release/sieve
echo Rust
cargo --version
