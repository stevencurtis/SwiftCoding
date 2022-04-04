//
//  main.swift
//  FirstRetainStructs
//
//  Created by Steven Curtis on 18/03/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

struct Tutorial {
    private var students = [Student]()
    mutating func enroll(_ student: Student) {
        students.append(student)
    }
}

struct Student {
    var tutorial : Tutorial
    var name : String
    init(tutorial: Tutorial, name: String) {
        self.tutorial = tutorial
        self.name = name
    }
}

var computing : Tutorial? = Tutorial()
var dave : Student? = Student(tutorial: computing!, name: "Dave")
computing?.enroll(dave!)
dave?.name

computing = nil
dave = nil
