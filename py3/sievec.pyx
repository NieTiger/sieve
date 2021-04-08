from cpython cimport array
import cython

cdef int sqrt(int n):
    cdef int l, r, mid
    if n <= 0:
        return 0
    if n < 2:
        return n
    l = 0
    r = n//2
    while l < r:
        mid = l + (r-l)//2
        if mid*mid < n:
            l = mid + 1
        else:
            r = mid
    return l


def sieve(int size):
    cdef int factor, i, q, incr
    cdef array.array arr = array.array('b', [0 for _ in range(size)])
    cdef char[:] a = arr

    if size < 2:
        return []

    # keep track of odd values only (don't look at even indices)
    q = sqrt(size)
    factor = 3

    while factor < q:
        for i in range(factor, size, 2):
            if a[i] == 0:
                # found a new prime
                factor = i
                break

        # remove all multiples of this prime
        i = factor * factor
        incr = factor * 2
        while i < size:
            a[i] = 1
            i += incr

        # for i in range(factor * 3, size, factor * 2):
            # a[i] = 1

        factor += 2

    return [2] + [i for i in range(3, size, 2) if a[i] == 0]
