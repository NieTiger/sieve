#include <chrono>
#include <cmath>
#include <fstream>
#include <iostream>
#include <vector>

std::vector<int> sieve(int size) {
  if (size < 2)
    return {};

  std::vector<bool> a = std::vector<bool>(size);
  int q = std::sqrt(size);
  int factor = 3;

  while (factor < q) {
    for (int i = factor; i < size; i += 2) {
      if (!a[i]) {
        factor = i;
        break;
      }
    }

    for (int i = factor * 3; i < size; i += factor * 2) {
      a[i] = true;
    }

    factor += 2;
  }

  std::vector<int> res = {2};
  for (int i = 3; i < size; i += 2) {
    if (!a[i])
      res.emplace_back(i);
  }
  return res;
}

std::vector<int> load_truth() {
  std::ifstream s("../truth.txt");
  std::vector<int> truth;
  if (!s.is_open()) {
    std::cerr << "Failed to open truth file\n";
    exit(1);
  }
  int curr;
  while (s >> curr) {
    truth.emplace_back(curr);
  }
  return truth;
}

int main() {
  // Test impl
  auto truth = load_truth();
  auto res = sieve(10000);
  if (truth.size() != res.size()) {
    std::cerr << "Impl error\n";
    exit(1);
  }
  for (int i = 0; i < truth.size(); i++) {
    if (truth[i] != res[i]) {
      std::cerr << "Impl error\n";
      exit(1);
    }
  }

  // Bench
  auto start = std::chrono::steady_clock::now();
  auto duration = std::chrono::seconds(5);
  int passes = 0;
  while (std::chrono::steady_clock::now() - start < duration) {
    sieve(10000);
    passes++;
  }
  std::cout << passes << std::endl;
}
