from typing import List
import sievec as sieve


def load_truth() -> List[int]:
    with open("../truth.txt", "r") as fp:
        data = fp.read()

    return [int(i) for i in data.split()]


if __name__ == "__main__":
    assert sieve.sieve(10000) == load_truth(), "implementation incorrect"

    import timeit

    size = 10000
    n_times = 500

    start = timeit.default_timer()
    n_seconds = 5
    n_passes = 0
    while timeit.default_timer() - start < 5:
        sieve.sieve(size)
        n_passes += 1

    print(n_passes)
