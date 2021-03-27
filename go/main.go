package main

import (
	"encoding/json"
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

type Config struct {
	Size       int
	Duration_s int
}

func load_config() Config {
	raw, err := ioutil.ReadFile("../config.json")
	if err != nil {
		log.Fatal(err)
	}

	var config Config

	err = json.Unmarshal(raw, &config)
	if err != nil {
		log.Fatal("json parse error: ", err)
	}

	return config
}

func main() {
	// Test implementation
	truth := load_truth()
	res := Sieve(10000)
	if len(res) != len(truth) {
		log.Fatal("Implementation error")
	}

	for i, v := range truth {
		if v != res[i] {
			log.Fatal("Implementation error")
		}
	}

	// Bench
	config := load_config()
	duration_ns := time.Duration(config.Duration_s * 1000000000)
	size := 10000

	start := time.Now()
	n_passes := 0
	for time.Since(start) < duration_ns {
		Sieve(size)
		n_passes += 1
	}

	fmt.Println(n_passes)
}
