mod sieve;

use std::fs;
use std::time::Instant;

fn read_truth() -> Vec<usize> {
    let raw = fs::read_to_string("../truth.txt").expect("Something went wrong reading the file.");
    let parts = raw.split(" ");
    let mut truth = vec![];

    for part in parts {
        let i: usize = part.trim().parse().unwrap();
        truth.push(i);
    }

    return truth;
}


fn main() {
    let truth = read_truth();
    let res = sieve::sieve(1_000_000);
    if !(truth == res) {
        println!("Impl error");
    }

    let five_s = std::time::Duration::from_secs(5);
    let end = Instant::now() + five_s;

    let mut count = 0;
    while Instant::now() < end {
        sieve::sieve(1_000_000);
        count += 1;
    }

    println!("{}", count);
}
