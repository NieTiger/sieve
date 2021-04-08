const fs = require("fs");
const { performance } = require("perf_hooks");

function sieve(size) {
  if (size < 2) {
    return [];
  }

  const a = new Int8Array(size);
  const q = Math.sqrt(size);
  let factor = 3;

  while (factor < q) {
    for (let i = factor; i < size; i += 2) {
      if (a[i] == 0) {
        factor = i;
        break;
      }
    }

    for (let i = factor * factor; i < size; i += factor * 2) {
      a[i] = 1;
    }

    factor += 2;
  }

  const res = [2];
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

function exitErr(n, ...msg) {
  console.log(msg);
  process.exit(n);
}

function main() {
  const size = 1000000;

  // Test impl
  const truth = loadTruth();

  const res = sieve(size);
  if (truth.length != res.length) {
    console.log("truth size: ", truth.length, " res size: ", res.length);
  }

  for (let i = 0; i < truth.length; i += 1) {
    if (res[i] != truth[i]) {
      console.log(`truth[${i}]=${truth[i]}, res[${i}]=${res[i]}`);
      exitErr(1, "Impl incorrect");
    }
  }

  // Benchmark
  const duration_s = 5;
  const duration_ms = duration_s * 1000;
  const start = performance.now();
  let passes = 0;
  while (performance.now() - start < duration_ms) {
    sieve(size);
    passes += 1;
  }

  console.log(passes);
}

main();
