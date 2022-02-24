#!/bin/bash
# CPython3
python3 main.py
echo CPython3
python3 --version
echo

# CPython3 + Numba
python3 main_numba.py
echo Py3/Numba
python3 --version
python3 -c "import numba; print('Numba', numba.__version__)"
echo

pypy3 main.py
echo pypy3
pypy3 --version

