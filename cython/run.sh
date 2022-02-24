#!/bin/bash

make 2>&1 1>/dev/null
python3 main.py
echo Cython
python3 -c "import Cython; print('Cython', Cython.__version__)"
python3 --version
echo
