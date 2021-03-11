//
//  inplacesolution.swift
//  IndexForArray
//
//  Created by Steven Curtis on 26/06/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

func inplacesolution(_ array: inout [Int]) {
    for index in 0..<array.count {
        while array[index] - 1 != index {
            array.swapAt(index, array[index] - 1)
        }
    }
    
}

