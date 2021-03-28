from typing import List, NamedTuple
from pathlib import Path
import os
import pickle
import shlex
import subprocess

import matplotlib.pyplot as plt


def check_output(cmd: str, cwd=".") -> str:
    proc = subprocess.run(
        shlex.split(cmd), stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=cwd
    )
    return proc.stdout.decode()


class Result(NamedTuple):
    lang: str
    version: str
    passes: int

def plot_results(results):
    _, ax = plt.subplots(figsize=(8, 6))
    ax.bar([r.lang for r in results], [r.passes for r in results])
    ax.set_title("Sieve bench")
    plt.savefig("plot.png")
    plt.show()


def main():
    root = Path(".")
    uname = check_output("uname -a")
    print(uname)

    results = []
    for dir in root.iterdir():
        if not dir.is_dir() or not (dir / "run.sh").exists():
            continue

        res = check_output("./run.sh", cwd=dir).strip()
        for r in res.split("\n\n"):
            print(r, end="\n\n")
            passes, lang, version = r.split("\n", maxsplit=2)
            results.append(Result(passes=int(passes), lang=lang, version=version))

    results.sort(key=lambda x: x.passes, reverse=True)
    with open("results.pkl", "wb") as fp:
        pickle.dump(results, fp)
    plot_results(results)


if __name__ == "__main__":
    main()
