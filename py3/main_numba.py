from typing import List
import math

from numba import jit
import numpy as np


@jit()
def sieve(size: int):
    if size < 2:
        return [np.int64(i) for i in range(0)]

    # keep track of odd values only (don't look at even indices)
    # a = bytearray(size)
    a = np.zeros(size, dtype=np.uint8)
    q = math.floor(math.sqrt(size))
    factor = 3

    while factor < q:
        for num in range(factor, size, 2):
            if a[num] == 0:
                # found a new prime
                factor = num
                break

        # remove all multiples of this prime
        for num in range(factor * factor, size, factor * 2):
            a[num] = 1

        factor += 2

    return [2] + [i for i in range(3, len(a), 2) if a[i] == 0]


def load_truth():
    with open("../truth.txt", "r") as fp:
        data = fp.read()

    return np.asarray([int(i) for i in data.split()])


def main():
    size = 1000000
    assert np.allclose(sieve(size), load_truth()), "implementation incorrect"

    import timeit

    end = timeit.default_timer() + 5
    n_passes = 0
    while timeit.default_timer() < end:
        sieve(size)
        n_passes += 1

    print(n_passes)


if __name__ == "__main__":
    main()
