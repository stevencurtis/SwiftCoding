//
//  main.swift
//  AccessControl
//
//  Created by Steven Curtis on 03/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

//private
//fileprivate
//internal
//public
//open

//
class Animal {
    open var name : String?
}

class Dog: Animal {
    public var age = 12
}

let animal = Animal()
animal.name = "AA"
print (animal.name)

let puppy = Dog()
puppy.name = "Dave"
print (puppy.name)
