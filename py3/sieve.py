from typing import List
import math


def sieve(size: int) -> List[int]:
    if size < 2:
        return []

    # keep track of odd values only (don't look at even indices)
    size2 = size // 2;
    a = bytearray(size2)
    q = math.floor(math.sqrt(size))
    factor = 3

    while factor < q:
        for num in range(factor//2, size2, 1):
            if a[num] == 0:
                # found a new prime
                factor = num*2 + 1
                break

        # remove all multiples of this prime
        for num in range((factor * factor)//2, size2, factor):
            a[num] = 1

        factor += 2

    return [2] + [i for i in range(3, size, 2) if a[i//2] == 0]
