#!/bin/bash
mkdir -p docs
cp ./README.md docs/index.md
python3 -m mkdocs build
