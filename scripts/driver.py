#!/usr/bin/env python3
from typing import NamedTuple
from pathlib import Path
import sys
import pickle
import shlex
import subprocess

import matplotlib.pyplot as plt


def check_output(cmd: str, cwd=".") -> str:
    try:
        proc = subprocess.run(
            shlex.split(cmd), stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=cwd
        )
    except (FileNotFoundError, PermissionError):
        print("Error: '{}' failed to execute.".format(cmd), file=sys.stderr)
        return ""
    else:
        return proc.stdout.decode()


class Result(NamedTuple):
    lang: str
    version: str
    passes: int
    raw_output: str


def plot_results(results, title="Sieve bench"):
    results.sort(key=lambda v: v.passes)

    with plt.xkcd():

        fig = plt.figure(figsize=(8, 6))
        ax = fig.add_axes((0.2, 0.2, 0.7, 0.7))

        ax.barh([r.lang for r in results], [r.passes for r in results])

        ax.set_title(title)
        ax.set_xlabel("# passes in 5 seconds")

        plt.savefig("docs/plot1.png")

        plt.show()


results_tmpl = r"""
# Raw Results

Code executed on GitHub Actions. Plot and raw results are below.

![plot](./plot1.png)

```
{}
```
"""


def main():
    root = Path(".")
    uname = "\n".join((check_output("lsb_release -a"), check_output("uname -a")))
    print(uname)

    results = []
    for dir in root.iterdir():
        if not dir.is_dir() or not (dir / "run.sh").exists():
            continue

        res = check_output("./run.sh", cwd=dir).strip()
        for r in res.split("\n\n"):
            print(r, end="\n\n")
            passes, lang, version = r.split("\n", maxsplit=2)
            results.append(
                Result(passes=int(passes), lang=lang, version=version, raw_output=res)
            )

    results.sort(key=lambda x: x.passes, reverse=True)
    with open("results.pkl", "wb") as fp:
        pickle.dump(results, fp)

    results_str = "\n\n".join([result.raw_output for result in results])
    results_str = "\n\n".join((uname, results_str))

    with open("docs/results.md", "w") as fp:
        tmp = results_tmpl.format(results_str)
        fp.write(tmp)

    plot_results(results)


if __name__ == "__main__":
    main()
