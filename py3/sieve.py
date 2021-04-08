from typing import List
import math


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
