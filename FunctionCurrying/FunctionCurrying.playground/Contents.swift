import UIKit

// addition
func add(_ num1: Int, num2: Int) -> Int {
    return num1 + num2
}

add(3, num2: 4)

func add(_ num: Int) -> (Int) -> Int {
    return {
        return $0 + num
    }
}

add(3)(4)

// triple add

func sum(_ num: Int) -> (Int) -> (Int) -> Int {
    return { y in
        return { z in
            return num + y + z
        }
    }
}

sum(2)(4)(8)

// curry

func curry(_ function: @escaping (Int, Int) -> Int) -> (Int) -> (Int) -> Int {
    { (a: Int) in
        { (b: Int) in
            return function(a, b)
        }
    }
}

let curriedAdd = curry(add)
let addTwo = curriedAdd(2)
curriedAdd(2)(3)

let x = (1...3).map(addTwo) // [3, 4, 5 etc.]
let xp = (1...3).map(addTwo).reduce(0, +)

// generic curry

func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> ((B) -> C) {
    return { (a: A) -> ((_ b: B) -> C) in
        return { (b: B) -> C in f(a, b) }
    }
}

curry(add)(4)(5)

// uncurry

func uncurry<A, B, C>(_ f: @escaping ((A) -> ((B) -> C) )) -> (A, B) -> C {
    return { (a: A, b: B) -> C in
        return f(a)(b)
    }
}

let uncurried = uncurry(curry(add))
uncurried(4, 5)
