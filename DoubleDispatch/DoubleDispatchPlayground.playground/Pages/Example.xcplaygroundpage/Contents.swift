//: [Previous](@previous)

import Foundation

protocol Visitor {
    func visit(s: Shape)
    func visit(d: Dot)
}

class Draw: Visitor {
    func visit(s: Shape) {
        print ("Drew Shape")
    }
    
    func visit(d: Dot) {
        print ("Drew Dot")
    }
}

protocol Visitable {
    func accept(_ v: Visitor)
}

class Shape: Visitable {
    func accept(_ v: Visitor) {
        v.visit(s: self)
    }
}

class Dot: Shape {
    override func accept(_ v: Visitor) {
        v.visit(d: self)
    }
}

let visitor = Draw()
let shape = Shape()
shape.accept(visitor) // Drew Shape

let dot = Dot()
dot.accept(visitor) // Drew Dot

//: [Next](@next)
