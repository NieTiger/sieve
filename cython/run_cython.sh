#!/bin/bash
make >/dev/null 2>&1
python3 main.py
echo Py3/Cython
python3 -c "import Cython; print('Cython', Cython.__version__)"
python3 --version
echo
