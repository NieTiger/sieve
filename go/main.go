package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"strconv"
	"strings"
	"time"
)

func load_truth() []int {
	raw, err := ioutil.ReadFile("../truth.txt")
	if err != nil {
		log.Fatal(err)
	}

	data := make([]int, 0)
	for _, v := range strings.Fields(string(raw)) {
		tmp, err := strconv.Atoi(v)
		if err != nil {
			log.Fatal(err)
		}
		data = append(data, tmp)
	}

	return data
}

func main() {
	size := 1000000

	// Test implementation
	truth := load_truth()
	res := Sieve(size)
	if len(res) != len(truth) {
		log.Fatal("Implementation error")
	}

	for i, v := range truth {
		if v != res[i] {
			log.Fatal("Implementation error")
		}
	}

	// Bench
	duration_s := 5
	duration_ns := time.Duration(duration_s * 1000000000)

	start := time.Now()
	n_passes := 0
	for time.Since(start) < duration_ns {
		Sieve(size)
		n_passes += 1
	}

	fmt.Println(n_passes)
}
