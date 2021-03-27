package main

import (
	"math"
)

func Sieve(size int) []int {
	if size < 2 {
		return []int{}
	}

	a := make([]bool, size)
	q := int(math.Sqrt(float64(size)))
	factor := 3

	for factor < q {
		for i := factor; i < size; i += 2 {
			if !a[factor] {
				factor = i
				break
			}
		}

		for i := factor * 3; i < size; i += factor * 2 {
			a[i] = true
		}

		factor += 2
	}

	res := []int{2}
	for i := 3; i < size; i += 2 {
		if !a[i] {
			res = append(res, i)
		}
	}

	return res
}
