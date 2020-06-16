//
//  Person.swift
//  VisualMemoryDebugger
//
//  Created by Steven Curtis on 12/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

class Parent {
    var name: String
    // if weak does not appear in the declaration below, there will be a retain cycle
    weak var child: Child?
    init(name: String, child: Child? = nil) {
        self.name = name
        self.child = child
    }
}

class Child {
    var name: String
    var parent: Parent
    init(name: String, parent: Parent) {
        self.name = name
        self.parent = parent
    }
}
