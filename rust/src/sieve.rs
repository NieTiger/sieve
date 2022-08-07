pub fn sieve(size: usize) -> Vec<usize> {
    if size < 2 {
        return vec![];
    }

    let size2 = (size >> 1) as usize;
    let mut a = Vec::with_capacity(size2);
    a.resize(size2, 0);
    let q = (size as f64).sqrt().floor() as usize;
    let mut factor: usize = 3;

    while factor < q {
        for i in (factor..size).step_by(2) {
            if a[i >> 1] == 0 {
                factor = i;
                break;
            }
        }

        for i in (factor * factor..size).step_by(factor * 2) {
            a[i >> 1] = 1;
        }

        factor += 2;
    }

    a[0] = 2;
    let mut n_primes_found = 1;
    for i in (3..size).step_by(2) {
        if a[i >> 1] == 0 {
            a[n_primes_found] = i;
            n_primes_found += 1;
        }
    }
    a.resize(n_primes_found, 0);

    return a;
}
