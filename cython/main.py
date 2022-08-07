from sieve import sieve
import numpy as np


def load_truth() -> np.ndarray:
    return np.loadtxt("../truth.txt", delimiter=" ", dtype=int)


def main():
    size = 1000000
    assert np.allclose(sieve(size), load_truth()), "implementation incorrect"

    import timeit

    duration_s = 5
    end_t = timeit.default_timer() + duration_s
    n_passes = 0
    while timeit.default_timer() < end_t:
        sieve(size)
        n_passes += 1

    print(n_passes)


if __name__ == "__main__":
    main()
