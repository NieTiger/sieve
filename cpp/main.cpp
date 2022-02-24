#include <chrono>
#include <cmath>
#include <fstream>
#include <iostream>
#include <vector>

std::vector<unsigned int> sieve(unsigned int size) {
  if (size < 2)
    return {};

  auto a = std::vector<unsigned int>(size);
  unsigned int q = std::sqrt(size);
  unsigned int factor = 3;

  while (factor < q) {
    for (auto i = factor; i < size; i += 2) {
      if (!a[i]) {
        factor = i;
        break;
      }
    }

    for (auto i = factor * factor; i < size; i += factor * 2)
      a[i] = 1;

    factor += 2;
  }

  std::vector<unsigned int> res = {2};
  for (auto i = 3; i < size; i += 2) {
    if (!a[i])
      res.push_back(i);
  }
  return res;
}

std::vector<unsigned int> load_truth() {
  std::ifstream s("./truth.txt");
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

void validate(std::vector<unsigned int> a1, std::vector<unsigned int> a2) {
  if (a1.size() != a2.size()) {
    std::cerr << "Impl error\n";
    std::cerr << "a1 size: " << a1.size() << ", a2 size: " << a2.size()
              << std::endl;
  }
  for (size_t i = 0; i < a1.size(); i++) {
    if (a1[i] != a2[i]) {
      std::cerr << "Impl error\n";
      std::cerr << "a1[" << i << "]=" << a1[i] << ", a2[" << i
                << "]=" << a2[i] << std::endl;
      exit(1);
    }
  }
}

int main() {
  int size = 1000000;

  // Test impl
  auto truth = load_truth();
  auto res = sieve(size);
  validate(truth, res);

  // Bench
  auto start = std::chrono::steady_clock::now();
  auto duration = std::chrono::seconds(5);
  int passes = 0;
  while (std::chrono::steady_clock::now() - start < duration) {
    res = sieve(size);
    passes++;
  }
  std::cout << passes << std::endl;
}