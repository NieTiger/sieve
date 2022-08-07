# distutils: language=c++
# cython: language_level=3
import cython
import numpy as np
cimport csieve


def sieve(unsigned int size):
    return np.array(csieve.sieve(size))
