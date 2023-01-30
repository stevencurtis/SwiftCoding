//
//  main.swift
//  Operations
//
//  Created by Steven Curtis on 21/09/2020.
//

import Foundation

func inc(x: inout Int) {
    x = x + 1
}

var val = 2
inc(x: &val)
print (val)

func assign(x: inout Int, y: inout Int) {
    let temp = y
    x = y
    y = temp
}

var firstVal = 2
var secondVal = 3
assign(x: &firstVal, y: &secondVal)
print (firstVal, secondVal)


func zero(x: inout Int) {
    x = 0
}

var preZero = 6
zero(x: &preZero)
print (preZero)



func loop(_ times: Int, _ function: () -> ()) {
    for _ in 0 ..< times {
        function()
    }
}

var num = 1

loop(10) {
    inc(x: &num)
    print("Hi!\(num)")
}



func dec(x: inout Int) {
    var y = 0
    var z = 0

    loop(x) {
        y = z
        inc(x: &z)
    }
    x = y
}

var numToDec = 4
dec(x: &numToDec)



func sub(x: inout Int, y: Int) {
    loop (y)
        { dec(x: &x) }
}

var numToSum = 4
sub(x: &numToSum, y: 3)
print (numToSum)




func isZero(x: Int) -> Int {
    var y = 1
    loop (x)
        { y = 0 }
    return y
}

var isThisZero = 2
print (isZero(x: isThisZero))






func lessThanEqual(x: Int, y: Int) -> Int {
    var initial = x
    sub(x: &initial, y: y)
    return isZero(x: initial)
}

print (lessThanEqual(x: 3, y: 2))




func greaterThanEqual(x: Int, y: Int) -> Int {
    return lessThanEqual(x: y, y: x)
}

func not(x: Int) -> Int {
    return isZero(x: x)
}

print (not(x: 0))
print (not(x: 1))



func greaterThan(x: Int, y: Int) -> Int {
    let z = lessThanEqual(x: x, y: y)
    return not(x: z)
}


func lessThan(x: Int, y: Int) -> Int {
    return greaterThan(x: y, y: x)
}

func add(x: Int, y: inout Int) -> Int {
    loop (x)
        { inc(x: &y) }
    return y
}

func multiply(x: Int, y: Int) -> Int {
    var z = 0
    loop (x) { z = add(x: y, y: &z) }
    return z
}

print(multiply(x: 2, y: 8))

func and(x: Int, y: Int) -> Int {
    return multiply(x: x, y: y)
}

print (and(x: 0, y: 0))
print (and(x: 0, y: 1))
print (and(x: 1, y: 0))
print (and(x: 1, y: 1))


