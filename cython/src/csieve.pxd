import cython
from libcpp.vector cimport vector

cdef extern from "sieve.h":

    vector[unsigned int] sieve(unsigned int size);
