from typing import List
import math

from numba import jit


@jit()
def sieve(size: int) -> List[int]:
    if size < 2:
        return []

    # keep track of odd values only (don't look at even indices)
    a = bytearray(size)
    q = math.sqrt(size)
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


def load_truth() -> List[int]:
    with open("../truth.txt", "r") as fp:
        data = fp.read()

    return [int(i) for i in data.split()]


def main():
    size = 1000000
    assert sieve(size) == load_truth(), "implementation incorrect"

    import timeit

    duration_s = 5
    start = timeit.default_timer()
    n_passes = 0
    while timeit.default_timer() - start < duration_s:
        sieve(size)
        n_passes += 1

    print(n_passes)


if __name__ == "__main__":
    main()
