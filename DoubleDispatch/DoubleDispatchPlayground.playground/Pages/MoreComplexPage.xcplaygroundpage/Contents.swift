//: [Previous](@previous)

import Foundation

protocol Visitable {
    func accept(_ visitor: Visitor)
}

protocol Visitor {
    func visit(rectangle: Rectangle)
    func visit(circle: Circle)
}

class Rectangle: Visitable {
    let width: Double
    let height: Double

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }

    func accept(_ visitor: Visitor) {
        visitor.visit(rectangle: self)
    }
}

class Circle: Visitable {
    let radius: Double

    init(radius: Double) {
        self.radius = radius
    }

    func accept(_ visitor: Visitor) {
        visitor.visit(circle: self)
    }
}

class AreaCalculator: Visitor {
    func visit(rectangle: Rectangle) {
        let area = rectangle.width * rectangle.height
        print("Area: \(area)")
    }

    func visit(circle: Circle) {
        let area = Double.pi * pow(circle.radius, 2)
        print("Area: \(area)")
    }
}

let rectangle = Rectangle(width: 10, height: 5)
let circle = Circle(radius: 3)
let areaCalculator = AreaCalculator()

rectangle.accept(areaCalculator) // Area: 50.0
circle.accept(areaCalculator) // Area: 28.274333882308138

//: [Next](@next)
