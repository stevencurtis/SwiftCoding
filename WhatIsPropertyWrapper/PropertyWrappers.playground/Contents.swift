import UIKit

struct Squared {
    private var edge: Double
    
    var area: Double {
        get {
            edge * edge
        }
        set{
            edge = sqrt(newValue)
        }
    }
    
    init(edge: Double) {
        self.edge = edge
    }
}

let sq = Squared(edge: 10)
print(sq.area)






@propertyWrapper
struct Square {
    private var value: Double

    var wrappedValue: Double {
        get {
            value * value
        }
        set {
            value = sqrt(newValue)
        }
    }
    
    init(wrappedValue: Double) {
        value = wrappedValue
    }
}

struct Squares {
    private var _edge: Square
    
    var area: Double {
        get {
            _edge.wrappedValue
        }
        set{
            _edge.wrappedValue = newValue
        }
    }
    
    init(edge: Double) {
        _edge = Square(wrappedValue: edge)
    }
}

var sr = Squares(edge: 10)
print(sr.area)
