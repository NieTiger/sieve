#include <chrono>
#include <cmath>
#include <fstream>
#include <iostream>
#include <vector>

std::vector<unsigned int> sieve(unsigned int size) {
  if (size < 2)
    return {};

  std::vector<bool> a = std::vector<bool>(size);
  unsigned int q = std::sqrt(size);
  unsigned int factor = 3;

  while (factor < q) {
    for (unsigned int i = factor; i < size; i += 2) {
      if (!a[i]) {
        factor = i;
        break;
      }
    }

    for (unsigned int i = factor * 3; i < size; i += factor * 2) {
      a[i] = true;
    }

    factor += 2;
  }

  std::vector<unsigned int> res = {2};
  for (unsigned int i = 3; i < size; i += 2) {
    if (!a[i])
      res.emplace_back(i);
  }
  return res;
}

std::vector<unsigned int> load_truth() {
  std::ifstream s("../truth.txt");
  std::vector<unsigned int> truth;
  if (!s.is_open()) {
    std::cerr << "Failed to open truth file\n";
    exit(1);
  }
  unsigned int curr;
  while (s >> curr) {
    truth.emplace_back(curr);
  }
  return truth;
}

int main() {
  int size = 1000000;

  // Test impl
  auto truth = load_truth();
  auto res = sieve(size);
  if (truth.size() != res.size()) {
    std::cerr << "Impl error\n";
    std::cerr << "Truth size: " << truth.size() << ", res size: " << res.size()
              << std::endl;
  }
  for (size_t i = 0; i < truth.size(); i++) {
    if (truth[i] != res[i]) {
      std::cerr << "Impl error\n";
      std::cerr << "truth[" << i << "]=" << truth[i] << ", res[" << i
                << "]=" << res[i] << std::endl;
      exit(1);
    }
  }

  // Bench
  auto start = std::chrono::steady_clock::now();
  auto duration = std::chrono::seconds(5);
  int passes = 0;
  while (std::chrono::steady_clock::now() - start < duration) {
    sieve(size);
    passes++;
  }
  std::cout << passes << std::endl;
}
