#!/bin/bash
# CPython3
python3 main.py
echo CPython3
python3 --version
echo

## CPython3 with numba
#python3 main_numba.py
#echo CPython3 + numba
#python3 --version
#python3 -c "import numpy; print('Numba', numpy.__version__)"
#echo

pypy3 main.py
echo pypy3
pypy3 --version

