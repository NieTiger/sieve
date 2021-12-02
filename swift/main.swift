import Foundation

func sieve(_ sz: Int) -> [Int] {
    if sz < 2 {
        return []
    }

    var a = Array(repeating: false, count: sz)
    let q = Int(sqrt(Double(sz)))
    var factor = 3

    while factor < q {
        for i in stride(from: factor, to: sz, by: 2) {
            if !a[i] {
                factor = i
                break
            }
        }

        for i in stride(from: factor*factor, to: sz, by: factor * 2) {
            a[i] = true;
        }

        factor += 2
    }

    var res = [2]
    for i in stride(from: 3, to: sz, by: 2) {
        if !a[i] {
            res.append(i)
        }
    }

    return res
}

func getTruth() -> [Int] {
    do {
        let raw = try String(contentsOfFile: "../truth.txt")
        return raw.trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: " ").map({ Int($0) ?? -1 })
    } catch {
        print(error.localizedDescription)
    }
    return []
}

enum SieveError: Error {
    case AlgorithmIncorrect
}

let truth = getTruth()
let res = sieve(1000000)
if truth != res {
    throw SieveError.AlgorithmIncorrect
}

let start_t = clock()
let target_td = CLOCKS_PER_SEC * 5
var counter = 0
while (clock() - start_t) < target_td {
    _ = sieve(1000000)
    counter += 1
    if truth != res {
        throw SieveError.AlgorithmIncorrect
    }
}
print(counter)
