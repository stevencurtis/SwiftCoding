//
//  main.swift
//  TrivialMemoryCycle
//
//  Created by Steven Curtis on 22/05/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

class Dog {
    var owner: Person?
}

class Person {
    var dog: Dog?
}

var mark : Person? = Person()
var pancho = Dog()
mark?.dog = pancho
pancho.owner = mark


mark = nil
print (mark)

// cannot seem to use the tools to check this with the memory debugger

