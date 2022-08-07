#!/usr/bin/env python3
from typing import NamedTuple
from pathlib import Path
import sys
import pickle
import shlex
import subprocess

import matplotlib.pyplot as plt

def _print(*args, **kwargs):
    print("[Driver]", *args, **kwargs)

def check_output(cmd: str, cwd=Path(".")) -> str:
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
    head = "\n".join((check_output("date"), check_output("lsb_release -a"), check_output("uname -a")))
    print(head)

    root = Path(".")
    results = []
    # iterate over top level directories
    for d in (d for d in root.iterdir() if d.is_dir()):

        # find all run scripts
        run_scripts = d.glob("run*.sh")
        for script in run_scripts:
            res = check_output("./" + script.name, cwd=d).strip()
            print(res, end="\n\n")
            try:
                passes, lang, version = res.split("\n", maxsplit=2)
                results.append(
                    Result(passes=int(passes), lang=lang, version=version, raw_output=res)
                )
            except Exception as e:
                _print("Failed to parse: ", res)
                _print(e, end="\n\n")

    results.sort(key=lambda x: x.passes, reverse=True)

    # pickle results
    with open("results.pkl", "wb") as fp:
        pickle.dump(results, fp)

    results_str = "\n\n".join([head] + [result.raw_output for result in results])

    with open("docs/results.md", "w") as fp:
        tmp = results_tmpl.format(results_str)
        fp.write(tmp)

    plot_results(results)


if __name__ == "__main__":
    main()
