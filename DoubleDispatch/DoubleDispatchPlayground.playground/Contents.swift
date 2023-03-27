import UIKit

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

protocol Graphic {
    func accept(_ v: Visitor)
}

class Shape: Graphic {
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
let graphic = Dot()

graphic.accept(visitor)

let shape = Shape()
shape.accept(visitor)
