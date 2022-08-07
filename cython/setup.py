from setuptools import setup, Extension
from Cython.Build import cythonize

extensions = [
    Extension(
        "sieve",
        sources=["./src/sieve.pyx", "../cpp/sieve.cpp"],
        include_dirs=["../cpp/"],
        extra_compile_args=["-std=c++17", "-O3", "-Wno-sign-compare"],
        language="c++",
    ),
]

setup(
    name="sieve",
    ext_modules=cythonize(
        extensions, compiler_directives={"language_level": "3"}, annotate=True
    ),
)
