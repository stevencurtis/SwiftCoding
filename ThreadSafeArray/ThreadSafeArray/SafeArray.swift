//
//  SafeArray.swift
//  ThreadSafeArray
//
//  Created by Steven Curtis on 15/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

public class SafeArray {
    private var array: [Int] = []
    private let accessQueue = DispatchQueue(label: "SynchronizedArrayAccess", attributes: .concurrent)
    
    init(repeating: Int, count: Int) {
        array = Array(repeating: repeating, count: count)
    }

    public func append(_ newElement: Int) {
        self.accessQueue.async(flags:.barrier) {
            self.array.append(newElement)
        }
    }

    public var count: Int {
        var count = 0
        self.accessQueue.sync {
            count = self.array.count
        }
        return count
    }

    var last: Int? {
        var element: Int?
        self.accessQueue.sync {
            if !self.array.isEmpty {
                element = self.array[self.array.count - 1]
            }
        }
        return element
    }
}
