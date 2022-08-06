package main

import (
	"math"
)

func Sieve(size int) []int {
	if size < 2 {
		return []int{}
	}

	a := make([]int, size/2)
	q := int(math.Sqrt(float64(size)))
	factor := 3

	for factor < q {
		for i := factor; i < size; i += 2 {
			if a[i>>1] == 0 {
				factor = i
				break
			}
		}

		for i := factor * factor; i < size; i += factor * 2 {
			a[i>>1] = 1
		}

		factor += 2
	}

	a[0] = 2
	prime_idx := 1
	for i := 3; i < size; i += 2 {
		if a[i>>1] == 0 {
			//res = append(res, i)
			a[prime_idx] = i
			prime_idx += 1
		}
	}

  return a[0:prime_idx]
}
