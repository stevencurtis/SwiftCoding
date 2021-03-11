//
//  findtheduplicate.swift
//  IndexForArray
//
//  Created by Steven Curtis on 26/06/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

func findDuplicate(_ nums: [Int]) -> Int {
    var nums = nums    
    for i in 0..<nums.count {
        while nums[i] - 1 != i {
            if nums[ nums[i] - 1] == nums[i] {
                return nums[i]
            }
            nums.swapAt(i, nums[i] - 1)
        }
    }
    return 0
}
