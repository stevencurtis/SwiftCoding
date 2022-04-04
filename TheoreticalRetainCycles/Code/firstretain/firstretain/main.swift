//
//  main.swift
//  firstretain
//
//  Created by Steven Curtis on 18/03/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

class Tutorial {
    private var students = [Student]()
    func enroll(_ student: Student) {
        students.append(student)
    }
    init() {
        print ("Tutorial initialized")
    }
    deinit {
        print ("Tutorial deinitialized")
    }
}

class Student {
    private var tutorial : Tutorial
    private var name : String
    init(tutorial: Tutorial, name: String) {
        print ("Tutorial initialized")
        self.tutorial = tutorial
        self.name = name
    }
    deinit {
        print ("Tutorial deinitialized")
    }
}

var computing : Tutorial? = Tutorial()
var dave : Student? = Student(tutorial: computing!, name: "Dave")
computing?.enroll(dave!)

computing = nil
dave = nil
