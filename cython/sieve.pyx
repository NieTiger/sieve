# distutils: language=c++
from libcpp.vector cimport vector
from libc.math cimport sqrt

def sieve(unsigned int size):
    cdef unsigned int factor, q, num
    cdef vector[unsigned int] a
    cdef vector[unsigned int] res

    if size < 2:
        return a

    a.reserve(size)
    q = <unsigned int>sqrt(size)
    factor = 3

    while factor < q:
        for num in range(factor, size, 2):
            if a[num] == 0:
                factor = num
                break

        for num in range(factor * factor, size, factor * 2):
            a[num] = 1

        factor += 2

    res.push_back(2)
    for num in range(3, size, 2):
        if a[num] == 0:
            res.push_back(num)

    return res

