from typing import List, NamedTuple
import json

import sievec as sieve


def load_truth() -> List[int]:
    with open("../truth.txt", "r") as fp:
        data = fp.read()

    return [int(i) for i in data.split()]


class Config(NamedTuple):
    size: int
    duration_s: int


def load_config() -> Config:
    with open("../config.json") as fp:
        raw = json.load(fp)

    return Config(raw["size"], raw["duration_s"])


if __name__ == "__main__":
    assert sieve.sieve(10000) == load_truth(), "implementation incorrect"

    import timeit

    config = load_config()

    start = timeit.default_timer()
    n_seconds = 5
    n_passes = 0
    while timeit.default_timer() - start < config.duration_s:
        sieve.sieve(config.size)
        n_passes += 1

    print(n_passes)
