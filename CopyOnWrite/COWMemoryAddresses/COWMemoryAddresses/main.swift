//
//  main.swift
//  COWMemoryAddresses
//
//  Created by Steven Curtis on 30/03/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

var array1 = ["Jim", "Kim"]
var array2 = array1
var arr1Location: UnsafeBufferPointer<String>? = nil
var arr2Location: UnsafeBufferPointer<String>? = nil

array1.withUnsafeBufferPointer { (point) in
    print(point) // UnsafeBufferPointer(start: 0x00000001006302e0, count: 2)
    arr1Location = point
}
array2.withUnsafeBufferPointer { (point) in
    print(point) // UnsafeBufferPointer(start: 0x00000001006302e0, count: 2)
    arr2Location = point
}
print(arr1Location?.baseAddress == arr2Location?.baseAddress) // true

array2[0] = "James"
array2.withUnsafeBufferPointer { (point) in
    print(point) // UnsafeBufferPointer(start: 0x000000010402f880, count: 2)
    arr2Location = point
}

print(arr1Location?.baseAddress == arr2Location?.baseAddress) // false
