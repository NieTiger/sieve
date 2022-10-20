#include <cmath>

#include "sieve.h"

std::vector<unsigned int> sieve(unsigned int size) {
  if (size < 2)
    return {};

  // because all prime numbers (except 2) must be odd, we can bit-shift all
  // numbers to the right by 1 and reduce our memory usage by half
  const auto size_2 = size >> 1;
  auto a = std::vector<unsigned int>(size_2);
  const unsigned int q = std::sqrt(size);

  for (unsigned int factor = 3; factor < q; factor += 2) {
    for (unsigned int i = factor; i < size; i += 2) {
      if (!a[i >> 1]) {
        factor = i;
        break;
      }
    }

    for (unsigned int i = factor * factor; i < size; i += factor * 2) {
      a[i >> 1] = 1;
    }
  }

  a[0] = 2;
  unsigned int n_primes_found = 1;
  for (unsigned int i = 3; i < size; i += 2)
    if (!a[i >> 1])
      a[n_primes_found++] = i;

  a.erase(a.begin() + n_primes_found, a.end());
  return a;
}
