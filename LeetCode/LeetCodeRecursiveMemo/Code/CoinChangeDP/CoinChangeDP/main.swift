//
//  main.swift
//  CoinChangeDP
//
//  Created by Steven Curtis on 22/03/2021.
//

import Foundation

//func ways(n: Int, coins: [Int]) -> Int {
//    var memo: [[Int]] = Array(repeating: Array(repeating: 0, count: coins.count), count: n)
//    return coinChange(n, coins, 0, 0, &memo)
//}
//
//// cache is a concatenation of amount - index
//func coinChange(_ target: Int, _ coins: [Int], _ ptr: Int, _ current : Int, _ memo: inout [[Int]])  -> Int {
//    if (current == target) {
//        return 1 }
//    if (ptr > coins.count - 1) {return 0}
//    if (current > target) {return 0}
//    var sum = 0
//    if (memo[current][ptr] != 0) {
//        return memo[current][ptr]
//    }
//
//    // add the current coin and don't move on
//    sum += coinChange(target, coins, ptr, current + coins[ptr], &memo )
//    // don't take the current coin, and therefore more on
//    sum += coinChange(target, coins, ptr + 1, current, &memo)
//    memo[current][ptr] = sum
//
//    return sum
//}


func ways(n: Int, coins: [Int]) -> Int {
    var memo: [Int] = Array(repeating: 0, count: n + 1)
    memo[0] = 1
    for coin in coins {
        for i in 1..<memo.count {
            if (i >= coin) {
                memo[i] += memo[i - coin]
            }
        }
        print(memo)
    }
    return memo[n]
}

//func ways(n: Int, coins: [Int]) -> Int {
//    var memo: [[Int]] = Array(repeating: Array(repeating: 0, count: coins.count), count: n + 1)
//    print(memo)
//    for i in 0..<coins.count {
//        memo[0][i] = 1
//    }
//    print(memo)
//    for i in 1...n {
//        for j in 0..<coins.count {
//
//            //solutions that include coins[j]
//            let x = i - coins[j] >= 0 ? memo[i - coins[j]][j] : 0
//            //solutions that don't include coins[j]
//            let y = j >= 1 ? memo[i][j-1] : 0
//
//            memo[i][j] = x + y
//        }
//    }
//    return memo[n][coins.count - 1]
//}


//func ways(n: Int, coins: [Int]) -> Int {
//
//    var table = Array<Array<Int>>(repeating: Array<Int>(repeating: 0, count: coins.count), count: n + 1)
//
//    for i in 0..<coins.count {
//        table[0][i] = 1
//    }
//
//    for i in 1...n {
//        for j in 0..<coins.count {
//
//            //solutions that include coins[j]
//            let x = i - coins[j] >= 0 ? table[i - coins[j]][j] : 0
//            //solutions that don't include coins[j]
//            let y = j >= 1 ? table[i][j-1] : 0
//
//            table[i][j] = x + y
//        }
//    }
//    return table[n][coins.count - 1]
//}

func getSolution(_ i: Int, _ j: Int) -> [[Int]] {
    let coins = [1,2,3]
    if j < 0 || i < 0 {
        //not a solution
        return []
    }
    if i == 0 && j == 0 {
        //valid solution. return an empty array where the coins will be appended
        return [[]]
    }
    return getSolution(i - coins[j], j).map{
        var a = $0
        a.append(coins[j])
        return a
    } + getSolution(i, j - 1)
}

//print(getSolution(4, 3))

print(ways(n: 4, coins: [1,2,3])) // 4
//print(ways(n: 12, coins: [1,2,5,10])) //15
//print(ways(n: 4, coins: [2,5,3,6])) // 1
//print(ways(n: 10, coins: [2,5,3,6])) // 5


