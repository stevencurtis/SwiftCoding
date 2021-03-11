//
//  main.swift
//  BFSForLeetCode
//
//  Created by Steven Curtis on 19/06/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

let dir:[[Int]] = [[0,1],[0,-1],[1,0],[-1,0],[1,-1],[-1,1],[-1,-1],[1,1]]
func shortestPathBinaryMatrix(_ grid: [[Int]]) -> Int {
    guard grid.count > 0 else {return 0}
    
    var grd = grid
    var coords : [(Int,Int)] = [(0,0)]
    var count = 1
    
    while !coords.isEmpty {
        let numberThisTurn = coords.count
        for _ in 0..<numberThisTurn {
            let currentCoordinate = coords.remove(at: 0)
            if grd[currentCoordinate.0][currentCoordinate.1] == 1 {continue}
            if currentCoordinate.0 == grd.count - 1 && currentCoordinate.1 == grd.count - 1 {
                return count
            }
            grd[currentCoordinate.0][currentCoordinate.1] = 1
            for direction in dir {
                let nextCoordinate = (currentCoordinate.0 + direction[0], currentCoordinate.1 + direction[1])
                
                if nextCoordinate.0 >= 0 && nextCoordinate.1 >= 0 && nextCoordinate.1 < grd.count && nextCoordinate.0 < grd.count {
                    coords.append(nextCoordinate)
                }
            }
        }
        count += 1
    }
    return -1
}

// bfs because dfs will involve going through ALL of the possibilities first and picking the shortest
// 1 is blocked, so once we have visited a square we can mark as 1 which indicates blocked

print (
    shortestPathBinaryMatrix([[0,1],[1,0]]) // 2
)

print (
    shortestPathBinaryMatrix([[0,0,0],[1,1,0],[1,1,0]]) // 4
)

print (
    shortestPathBinaryMatrix([[0,0,0],[1,1,0],[1,1,1]]) // -1
)

print (
    shortestPathBinaryMatrix([[0,0,0],[0,1,0],[0,0,0]]) // 4
)

