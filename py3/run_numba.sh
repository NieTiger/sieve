#!/bin/bash
# CPython3 + Numba
python3 main_numba.py
echo Py3/Numba
python3 --version
python3 -c "import numba; print('Numba', numba.__version__)"
echo

