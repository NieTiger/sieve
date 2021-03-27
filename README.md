# A biased and unscientific language performance benchmark for fun

The idea is to implement the [Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes) in a bunch of different language, try to optimised the implementations as much as possible, and measure the number of passes each sieve can run for `size = 10000` in 5 seconds.

The function `sieve` takes argument `size` of type `int` and returns a list of all prime numbers up to (and not including) size.

The implementation is checked against a [truth file](./truth.txt), which contains all primes up to 10000.
