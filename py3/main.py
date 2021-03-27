from typing import List
import math

def load_truth() -> List[int]:
    with open("../truth.txt", "r") as fp:
        data = fp.read()

    return [int(i) for i in data.split()]

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
        for num in range(factor * 3, size, factor * 2):
            a[num] = 1

        factor += 2

    return [2] + [i for i in range(3, len(a), 2) if a[i] == 0]

if __name__ == "__main__":
    assert sieve(10000) == load_truth(), "implementation incorrect"

    import timeit
    size = 10000
    n_times = 500

    start = timeit.default_timer()
    n_seconds = 5
    n_passes = 0
    while timeit.default_timer() - start < 5:
        sieve(size)
        n_passes += 1

    print(n_passes)
