from typing import List

from sieve import sieve


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
