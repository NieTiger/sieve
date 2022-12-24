import std/math


proc sieve(size: int): seq[int] =
  if size < 2: return @[]

  let 
    size2 = math.floorDiv(size, 2)
    q = int(math.sqrt(float(size)))

  var
    a = newSeq[int](size2)
    factor: int = 3

  while factor < q:
    for num in math.floorDiv(factor, 2)..size2:
      if a[num] == 0:
        factor = num * 2 + 1
        break
    
    for num in countup(math.floorDiv(factor * factor, 2), size2 - 1, factor):
      a[num] = 1

    factor += 2

  a[0] = 2
  var primes_found = 1
  for i in countup(3, size - 1, 2):
    if a[i shr 1] == 0:
      a[primes_found] = i
      primes_found += 1

  return a[0..<primes_found]


import std/strutils
import sugar

proc load_truth(fname: string): seq[int] =
  return collect(for x in readFile(fname).strip().split(' '): parseInt(x))


# Test correctness
let truth = load_truth("../truth.txt")
for i, v in sieve(1_000_000):
  assert truth[i] == v

import std/times

let t1 = cpuTime() + 5
var passes = 0
while cpuTime() < t1:
  discard sieve(1_000_000)
  passes += 1

echo passes