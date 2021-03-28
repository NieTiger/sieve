#!/bin/bash
python3 main.py
echo CPython3
python3 --version
echo

./build_cython.sh > /dev/null  # requires `python3 -m pip install cython`
if [ -z "$?" ]
then
  python3 main_cython.py
  echo Cython
  python3 -c "import cython; print(cython.__version__)"
  echo
fi

pypy3 main.py
echo pypy3
pypy3 --version
