from setuptools import setup
from Cython.Build import cythonize


setup(
    name="sieve",
    ext_modules=cythonize(["sieve.pyx"], annotate=True),
)
