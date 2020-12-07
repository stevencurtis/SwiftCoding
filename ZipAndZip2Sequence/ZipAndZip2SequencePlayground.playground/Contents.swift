import UIKit

var str = "Hello, playground"


let scores = [1,2,3]
let ages = [22,33,44]

let zipped = zip(scores, ages)

let pairs: Zip2Sequence<[Int], [Int]> = zip(scores, ages)

print (pairs)

for pair in pairs {
    print (pair)
    print (pair.0)
    print (pair.1)
}

typealias Game = (score: Int, age: Int)

let pairsArray = Array(pairs) as [Game]

for game in pairsArray  {
    print (game)
    print (game.age)
    print (game.score)
}
