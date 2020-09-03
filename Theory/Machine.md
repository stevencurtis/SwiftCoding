# Machine.md
import UIKit
//Written test presented me with imaginary, assembly-like programming language consisting of 4 instructions (ZERO, ASSIGN, INCR and LOOP). Over 10 questions of varying difficulty required me to write code using these instructions to complete more complex tasks (some of them were, as described by others: ADD, DECR, SUBT, MULT, MAX, MIN, GREATER, LESS, EQ, POW). I distinctly remember the longest question asked to implement function to find largest common denominator between 2 numbers. All in all this test was very enjoyable - I was given 40 minutes to completed which proved to be more than enough as there was sufficient time for me to go over each answer again to verify I haven't made any silly mistakes.


//We're only allowed to use the following operations:
//
//incr(x) - Once this function is called it will assign x + 1 to x
//assign(x, y) - This function will assign the value of y to x (x = y)
//zero(x) - This function will assign 0 to x (x = 0)
//loop X { } - operations written within brackets will be executed X times

func inc(num: Int) -> Int {
    return num + 1
}

func assign(x: inout Int, y: inout Int) {
    let temp = y
    x = y
    y = temp
}
//func zero(x: inout Int) {
//    x = 0
//}

// so we set resut to false if x is anything other than zero
//isZero(x) {
//    y = true
//    loop x { y = false }
//    return y
//}

func loop(times: Int, function: ((Int) -> Int)) {
    for i in 0..<times {
        function(<#Int#>)
    }
}


func add(num1: Int, num2: Int) -> Int {
    return num1 + num2
}

// https://stackoverflow.com/questions/34829670/relational-operations-using-only-increment-loop-assign-zero

//add(x, y) {
//    loop x
//        { y = incr(y) }
//    return y
//}

//sub(x, y) {
//    loop y
//        { x = decr(x) }
//    return x
//}

//decr(x) {
//    y = 0
//    z = 0
//
//    loop x {
//        y = z
//        z = incr(z)
//    }
//
//    return y
//}


// can use isZero to write branching code with 0 as false and 1 as true


//lte(x, y) {
//    z = sub(x, y)
//    z = isZero(z)
//    return z
//}


// https://stackoverflow.com/questions/34829670/relational-operations-using-only-increment-loop-assign-zero

