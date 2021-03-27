const fs = require("fs");
const { performance } = require('perf_hooks');

function sieve(size) {
  if (size < 2) {
    return [];
  }

  let a = new Int8Array(size);
  let q = Math.sqrt(size);
  let factor = 3;

  while (factor < q) {
    for (let i = factor; i < size; i += 2) {
      if (a[i] == 0) {
        factor = i;
        break;
      }
    }

    for (let i = factor * 3; i < size; i += factor * 2) {
      a[i] = 1;
    }

    factor += 2;
  }

  let res = [2];
  for (let i = 3; i < size; i += 2) {
    if (a[i] == 0) {
      res.push(i);
    }
  }

  return res;
}

function loadTruth() {
  let truth = null;
  try {
    // Read truth
    const data = fs.readFileSync("../truth.txt").toString();
    truth = data.split(" ").map((v) => Number(v));
  } catch (err) {
    console.log(err);
    exit(1);
  }
  return truth;
}

function loadConfig() {
  let config = null;
  try {
    // Read config
    const data = fs.readFileSync("../config.json");
    config = JSON.parse(data);
  } catch (err) {
    console.log(err);
    process.exit(1);
  }
  return config;
}

function exitErr(n, ...msg) {
  console.log(msg);
  process.exit(n);
}

function main() {
  // Test impl
  const truth = loadTruth();
  const config = loadConfig();

  let res = sieve(10000);
  if (truth.length != res.length) {
    exitErr(1, "Impl incorrect");
  }

  for (let i = 0; i < truth.length; i += 1) {
    if (res[i] != truth[i]) {
      exitErr(1, "Impl incorrect");
    }
  }

  // Benchmark
  let passes = 0
  let duration_ms = config.duration_s * 1000
  let start = performance.now()
  while (performance.now() - start < duration_ms) {
    sieve(config.size)
    passes += 1
  }

  console.log(passes)
}

main();
